//
//  SwiftRepository.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import Foundation

class SwiftRepository {
    
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
            
            struct Owner: Codable{
                var login: String?
            }
            
            struct License: Codable{
                var name: String?
            }
        }
        
    }
    
    static func requestRepositories(_ completion: @escaping (Result<Repository, Error>)->Void){
        
        guard let url = URL(string: "http://api.github.com/search/repositories?q=language:Swift&sort=stars") else { return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                completion(.failure(error))
                return
            }
            guard let data  = data else { return }
            guard let repository = try? JSONDecoder().decode(Repository.self, from: data) else { return }
            
            completion(.success(repository))
            
        }
        
        task.resume()
        
    }
    
}
