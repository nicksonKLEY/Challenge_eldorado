//
//  SegmentedViewControler.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

class SegmentedViewController: UIViewController {
    
    private let segmentedViews = ["All", "Saved"]
    
    let segmentedControl = UISegmentedControl()
    let tableView = UITableView()
    
    var repositories: [SwiftRepository.Repository.Item] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Swift Repositories"
        
        SwiftRepository.requestRepositories { result in
            switch result{
                case .success(let repository):
                    self.repositories = repository.items
                case .failure(let error):
                    print(error)
                    self.repositories = []
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        applyViewCode()
        
    }
    
}

extension SegmentedViewController : ViewCodeConfiguration{
    func buildHierarchy() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
            }
    
    func setupConstraint() {
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
        
        for (key, item) in segmentedViews.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: key, animated: true)
        }
        segmentedControl.addTarget(self, action: #selector(segmetedControlDidChange(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = UIColor(red: (87/255), green: (84/255), blue: (85/255), alpha: 1)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "RepositoryCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
    }
    
    @objc func segmetedControlDidChange(_ segmentedControl: UISegmentedControl){
        
        switch segmentedControl.selectedSegmentIndex {
        case 0://all repositories
            print(0)
        case 1://saved repositories
            print(1)
        default:
            return
        }
        
    }
    
    
}

extension SegmentedViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath as IndexPath)
        guard let repositoryCell = cell as? RepositoryTableViewCell else { return UITableViewCell() }
        
        let repository = repositories[indexPath.row]
        
        repositoryCell.name.text = repository.name
        repositoryCell.ownerLogin.text = repository.owner?.login ?? ""
        repositoryCell.descriptionLabel.text = repository.description
        repositoryCell.stargazers_count.text = String(repository.stargazers_count!)
        repositoryCell.license.text = repository.license?.name ?? "Unknow License"
        
        

        if let lastUpdate = repository.pushed_at{
            let formatter = ISO8601DateFormatter()
            let datetime = formatter.date(from: lastUpdate)
//            formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
            
            repositoryCell.pushed_at.text = formatter.string(from: datetime!)
        }
        
        return repositoryCell
    }
    
    
}
