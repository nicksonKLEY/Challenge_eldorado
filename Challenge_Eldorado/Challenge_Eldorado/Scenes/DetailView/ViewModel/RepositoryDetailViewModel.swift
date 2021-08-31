//
//  RepositoryDetailViewModel.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import UIKit

class RepositoryDetailViewModel {
    
    let repository: Repository.Item
    let title: String
    
    init(_ repository: Repository.Item) {
        self.repository = repository
        self.title = repository.name ?? ""
    }
    
}
