//
//  RepositoryDetailView.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import UIKit

class RepositoryDetailView: UIViewController {
    
    var viewModel: RepositoryDetailViewModel?
    
    let ownerLogin = UILabel()
    let descriptionLabel = UILabel()
    let stargazers_count = UILabel()
    let license = UILabel()
    let pushed_at = UILabel()
    
    let pullsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        
        title = viewModel.title
        
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
        ownerLogin.translatesAutoresizingMaskIntoConstraints = false
        stargazers_count.translatesAutoresizingMaskIntoConstraints = false
        pushed_at.translatesAutoresizingMaskIntoConstraints = false
        license.translatesAutoresizingMaskIntoConstraints = false
        pullsTableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureView() {
        
        pullsTableView.dataSource = self
        pullsTableView.delegate = self
        
        
        
    }
}

extension RepositoryDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
