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
        view.addSubview(ownerLogin)
        view.addSubview(stargazers_count)
        view.addSubview(pushed_at)
        view.addSubview(license)
        view.addSubview(pullsTableView)
        
    }
    
    func setupConstraint() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stargazers_count.translatesAutoresizingMaskIntoConstraints = false
        ownerLogin.translatesAutoresizingMaskIntoConstraints = false
        pushed_at.translatesAutoresizingMaskIntoConstraints = false
        license.translatesAutoresizingMaskIntoConstraints = false
        pullsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            stargazers_count.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 3),
            stargazers_count.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stargazers_count.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            
            ownerLogin.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 3),
            ownerLogin.leadingAnchor.constraint(equalTo: stargazers_count.trailingAnchor),
            ownerLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            pushed_at.topAnchor.constraint(equalTo: ownerLogin.bottomAnchor, constant: 3),
            pushed_at.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            pushed_at.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            
            license.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 3),
            license.leadingAnchor.constraint(equalTo: pushed_at.trailingAnchor),
            license.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            pullsTableView.topAnchor.constraint(equalTo: license.bottomAnchor, constant: 3),
            pullsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pullsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pullsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    func configureView() {
        
        descriptionLabel.text = viewModel.repository.description
        stargazers_count.text = String(viewModel.repository.stargazers_count ?? 0)
        ownerLogin.text = viewModel.repository.owner?.login ?? ""
        pushed_at.text = viewModel.repository.pushed_at
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
        pullCell.body.text = "#\(String(pull.number ?? 0000)) opened \(pull.created_at ?? "MM-dd") by \(pull.user?.login ?? "")"
        
        return pullCell
    }
    
}
