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
    
    let dataManager = RepositoryDataModel.shared
    
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
    
    @objc func rightNavButtonAction(){
        
        let id = repository.id
        let name = repository.name
        let login = repository.owner?.login
        let description = repository.description
        let stars = repository.stargazers_count
        let licenceName = repository.license?.name
        let pushed_at = repository.pushed_at
        
        let localRepository = LocalRepositoryModel(id: id, descriptionItem: description, licenseName: licenceName, login: login, name: name, pushed_at: pushed_at, stargazers_count: stars)
        
        if(dataManager.exist(idRepository: repository.id)){
            dataManager.delete(localModel: localRepository)
        } else {
            dataManager.create(localRepository)
        }
        
    }
}
