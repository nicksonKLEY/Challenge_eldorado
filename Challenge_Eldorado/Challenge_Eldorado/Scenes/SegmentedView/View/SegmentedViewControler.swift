//
//  SegmentedViewControler.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

class SegmentedViewController: UIViewController {
    
    private let viewModel = SegmentedViewModel()
    
    let segmentedControl = UISegmentedControl()
    let tableView = UITableView()
    
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = viewModel.title
        
//        viewModel.requestRepositories { result in
//            switch result{
//            case .success(let repository):
//                self.viewModel.repositories = repository.items
//            case .failure(let error):
//                print(error)
//                self.viewModel.repositories = []
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
        viewModel.repositoriesDidChange = tableView.reloadData
        viewModel.reloadTable(with: .allRepositories)
        
        applyViewCode()
        
    }
    
}

extension SegmentedViewController : ViewCodeConfiguration{
    func buildHierarchy() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
    }
    
    func setupConstraint() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    func configureView() {
        
        view.backgroundColor = .white
        
        for (key, item) in viewModel.segmentedViews.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: key, animated: true)
        }
        segmentedControl.addTarget(viewModel, action: #selector(viewModel.segmetedControlDidChange(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = UIColor(red: (87/255), green: (84/255), blue: (85/255), alpha: 1)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "RepositoryCell")
        
    }
    
    
    
}

extension SegmentedViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath as IndexPath)
        guard let repositoryCell = cell as? RepositoryTableViewCell else { return UITableViewCell() }
        
        let repository = viewModel.repositories[indexPath.row]
        
        repositoryCell.name.text = repository.name
        repositoryCell.ownerLogin.text = "created by: \(repository.owner?.login ?? "")"
        repositoryCell.descriptionLabel.text = repository.description
        repositoryCell.stargazers_count.text = "⭐️\(String(repository.stargazers_count ?? 0))"
        repositoryCell.license.text = repository.license?.name ?? "Unknow License"
        
        
        
        if let lastUpdate = repository.pushed_at {
            
            let formatter = ISO8601DateFormatter()
            if let datetime = formatter.date(from: lastUpdate){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YY/MM/dd"
                repositoryCell.pushed_at.text = "Last Update: \(dateFormatter.string(from: datetime))"
            }
        }
        
        return repositoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = viewModel.repositories[indexPath.row]
        
        let repositoryDetailViewModel = RepositoryDetailViewModel(repository)
        let repositoryDetail = RepositoryDetailView(repositoryDetailViewModel)
        
        
        repositoryDetail.viewModel = repositoryDetailViewModel
        
        self.navigationController?.pushViewController(repositoryDetail, animated: true)
    }
    
}
