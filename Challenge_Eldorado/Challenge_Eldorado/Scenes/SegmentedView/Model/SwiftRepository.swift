//
//  SwiftRepository.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import Foundation

struct Repository: Codable {
    
    var items: [Item]
    
    struct Item: Codable {
        var id: Int?
        var name: String?
        var owner: Owner?
        var description: String?
        var stargazers_count: Int?
        var license: License?
        var pushed_at: String?
        
        struct Owner: Codable {
            var login: String?
        }
        
        struct License: Codable {
            var name: String?
        }
    }
    
}
