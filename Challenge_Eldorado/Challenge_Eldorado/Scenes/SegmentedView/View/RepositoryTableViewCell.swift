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
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stargazers_count)
        contentView.addSubview(pushed_at)
        contentView.addSubview(license)
        contentView.addSubview(ownerLogin)
    }
    
    func setupConstraint() {
        
        name.translatesAutoresizingMaskIntoConstraints = false
        ownerLogin.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stargazers_count.translatesAutoresizingMaskIntoConstraints = false
        license.translatesAutoresizingMaskIntoConstraints = false
        pushed_at.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            
            stargazers_count.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stargazers_count.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            
            pushed_at.leadingAnchor.constraint(equalTo: stargazers_count.trailingAnchor, constant: 4),
            pushed_at.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            pushed_at.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            pushed_at.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            license.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            license.topAnchor.constraint(equalTo: pushed_at.bottomAnchor, constant: 10),
            license.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            ownerLogin.leadingAnchor.constraint(equalTo: license.trailingAnchor, constant: 4),
            ownerLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            ownerLogin.topAnchor.constraint(equalTo: pushed_at.bottomAnchor, constant: 1),
            ownerLogin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configureView() {
        
        name.textColor = UIColor(red: 155, gree: 35, blue: 147)
        name.textAlignment = .left
        name.font = name.font.withSize(30)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .justified
        
        license.textAlignment = .left
        license.textColor = UIColor(red: 69, gree: 69, blue: 69)
        
        ownerLogin.textAlignment = .right
        ownerLogin.textColor = UIColor(red: 69, gree: 69, blue: 69)
        
        
    }
    
}
