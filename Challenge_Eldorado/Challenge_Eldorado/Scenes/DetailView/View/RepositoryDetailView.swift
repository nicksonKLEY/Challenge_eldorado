//
//  RepositoryDetailView.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import UIKit

class RepositoryDetailView: UIViewController {
    
    var viewModel: RepositoryDetailViewModel
    
    let ownerLogin = UILabel()
    let descriptionLabel = UILabel()
    let stargazers_count = UILabel()
    let license = UILabel()
    let pushed_at = UILabel()
    
    let pullsTableView = UITableView()
    
    init(_ viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        viewModel.requestPullsRepository { result in
            switch result{
            case .success(let pulls):
                self.viewModel.pulls = pulls
            case .failure(let error):
                print(error)
                self.viewModel.pulls = []
            }
            
            DispatchQueue.main.async {
                self.pullsTableView.reloadData()
            }
            
        }
        
        applyViewCode()
    }
    
    
}

extension RepositoryDetailView : ViewCodeConfiguration{
    func buildHierarchy() {
        
        view.addSubview(descriptionLabel)
        view.addSubview(stargazers_count)
        view.addSubview(pushed_at)
        view.addSubview(license)
        view.addSubview(ownerLogin)
        view.addSubview(pullsTableView)
        
        guard let nav = self.navigationController else {
            return }
        
        nav.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: viewModel, action: #selector(viewModel.rightNavButtonAction))
        
    }
    
    func setupConstraint() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stargazers_count.translatesAutoresizingMaskIntoConstraints = false
        ownerLogin.translatesAutoresizingMaskIntoConstraints = false
        pushed_at.translatesAutoresizingMaskIntoConstraints = false
        license.translatesAutoresizingMaskIntoConstraints = false
        pullsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            stargazers_count.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            stargazers_count.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            pushed_at.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            pushed_at.leadingAnchor.constraint(equalTo: stargazers_count.trailingAnchor, constant: 3),
            pushed_at.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            license.topAnchor.constraint(equalTo: pushed_at.bottomAnchor, constant: 6),
            license.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            ownerLogin.topAnchor.constraint(equalTo: pushed_at.bottomAnchor, constant: 6),
            ownerLogin.leadingAnchor.constraint(equalTo: license.trailingAnchor),
            ownerLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            pullsTableView.topAnchor.constraint(equalTo: ownerLogin.bottomAnchor, constant: 10),
            pullsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pullsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pullsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    func configureView() {
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        stargazers_count.textAlignment = .left
        
        pushed_at.textAlignment = .right
        
        license.textAlignment = .left
        license.textColor = UIColor(red: 69, gree: 69, blue: 69)
        
        ownerLogin.textAlignment = .right
        ownerLogin.textColor = UIColor(red: 69, gree: 69, blue: 69)
        
        pullsTableView.layer.masksToBounds = true
        pullsTableView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        pullsTableView.layer.borderWidth = 2.0
        
        descriptionLabel.text = viewModel.repository.description
        stargazers_count.text = "⭐️\(String(viewModel.repository.stargazers_count ?? 0))"
        ownerLogin.text = "Created By: \(viewModel.repository.owner?.login ?? "")"
        
        if let lastUpdate = viewModel.repository.pushed_at {
            
            let formatter = ISO8601DateFormatter()
            if let datetime = formatter.date(from: lastUpdate){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YY/MM/dd"
                pushed_at.text = "Last Update: \(dateFormatter.string(from: datetime))"
            }
        }
        
        license.text = viewModel.repository.license?.name ?? ""
        
        pullsTableView.dataSource = self
        pullsTableView.delegate = self
        pullsTableView.register(PullsTableViewCell.self, forCellReuseIdentifier: "PullsCell")
        
    }
}

extension RepositoryDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pulls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullsCell")
        guard let pullCell = cell as? PullsTableViewCell else { return UITableViewCell() }
        
        let pull = viewModel.pulls[indexPath.row]
        
        pullCell.title.text = pull.title
        
        if let lastUpdate = viewModel.repository.pushed_at {
            
            let formatter = ISO8601DateFormatter()
            if let datetime = formatter.date(from: lastUpdate){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YY/MM/dd"
                pullCell.body.text = "#\(String(pull.number ?? 0000)) opened \(dateFormatter.string(from: datetime)) by \(pull.user?.login ?? "")"
            }
        }
        
        return pullCell
    }
    
}
