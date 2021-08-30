//
//  RepositoryTableViewCell.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    let name = UILabel()
    let ownerLogin = UILabel()
    let descriptionLabel = UILabel()
    let stargazers_count = UILabel()
    let license = UILabel()
    let pushed_at = UILabel()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        applyViewCode()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RepositoryTableViewCell: ViewCodeConfiguration{
    
    func buildHierarchy() {
        contentView.addSubview(name)
        contentView.addSubview(ownerLogin)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stargazers_count)
        contentView.addSubview(license)
        contentView.addSubview(pushed_at)
    }
    
    func setupConstraint() {
        
        name.translatesAutoresizingMaskIntoConstraints = false
        ownerLogin.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stargazers_count.translatesAutoresizingMaskIntoConstraints = false
        license.translatesAutoresizingMaskIntoConstraints = false
        pushed_at.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            name.heightAnchor.constraint(equalToConstant: 30),
            ownerLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ownerLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ownerLogin.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            ownerLogin.heightAnchor.constraint(equalToConstant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: ownerLogin.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            stargazers_count.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stargazers_count.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stargazers_count.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            stargazers_count.heightAnchor.constraint(equalToConstant: 30),
            license.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            license.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            license.topAnchor.constraint(equalTo: stargazers_count.bottomAnchor, constant: 10),
            license.heightAnchor.constraint(equalToConstant: 30),
            pushed_at.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pushed_at.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pushed_at.topAnchor.constraint(equalTo: license.bottomAnchor, constant: 10),
            pushed_at.heightAnchor.constraint(equalToConstant: 30),
            pushed_at.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureView() {
        
        
    }
    
}
