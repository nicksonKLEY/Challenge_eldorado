//
//  PullsTableViewCell.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import UIKit

class PullsTableViewCell: UITableViewCell {
    
    let title = UILabel()
    let body = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PullsTableViewCell: ViewCodeConfiguration{
    func buildHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(body)
    }
    
    func setupConstraint() {
        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 3),
            body.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            body.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            body.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
            
        ])
    }
    
    func configureView() {
        
    }
}
