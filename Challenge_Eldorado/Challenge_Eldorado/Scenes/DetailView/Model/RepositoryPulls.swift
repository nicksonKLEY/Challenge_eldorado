//
//  RepositoryPulls.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import Foundation

struct Pulls: Codable {
    
    let title: String?
    let number: Int?
    
    struct User: Codable {
        let login: String?
    }
    
    let user: User?
    let created_at: String?
}
