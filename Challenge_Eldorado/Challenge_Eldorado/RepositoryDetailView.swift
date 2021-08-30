//
//  RepositoryDetailView.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import UIKit

class RepositoryDetailView : UIViewController{
    
    var repository : SwiftRepository.Repository.Item? = nil
    
    let name = UILabel()
    let ownerLogin = UILabel()
    let descriptionLabel = UILabel()
    let stargazers_count = UILabel()
    let license = UILabel()
    let pushed_at = UILabel()
    
    let pullsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        title = repository?.name
        
        applyViewCode()
    }
    
    
}

extension RepositoryDetailView : ViewCodeConfiguration{
    func buildHierarchy() {
        view.addSubview(name)
    }
    
    func setupConstraint() {
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            name.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configureView() {
        name.text = "teste"
    }
}
