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
    
    var pulls: [Pulls] = []
    
    init(_ repository: Repository.Item) {
        self.repository = repository
        self.title = repository.name ?? ""
    }
    
    func requestPullsRepository(_ completion: @escaping (Result<[Pulls], Error>)->Void){
        guard let owner = repository.owner?.login else { return }
        guard let repositoryName = repository.name else { return }
        guard let url = URL(string: "http://api.github.com/repos/\(owner)/\(repositoryName)/pulls") else {
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            guard let pulls = try? JSONDecoder().decode([Pulls].self, from: data) else {
                return }
            
            completion(.success(pulls))
        }
        task.resume()
    }
    
}
