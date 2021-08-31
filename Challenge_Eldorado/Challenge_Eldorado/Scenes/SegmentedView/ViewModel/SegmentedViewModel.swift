//
//  SegmentedViewModel.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import UIKit

class SegmentedViewModel {
    
    enum tableInformations{
        case allRepositories
        case savedRepositories
    }
    
    let segmentedViews = ["All", "Saved"]
    let title = "Swift Repositories"
    var repositories: [Repository.Item] = []
    
    var repositoriesDidChange : ()->Void = {}
    
    func reloadTable(with tableInformation: tableInformations){
        switch tableInformation {
        case .allRepositories:
            self.requestRepositories { result in
                switch result{
                case .success(let repository):
                    self.repositories = repository.items
                case .failure(let error):
                    print(error)
                    self.repositories = []
                }
                DispatchQueue.main.async {
                    self.repositoriesDidChange()
                }
            }
        case .savedRepositories:
            self.fetchSavedRepositories { result in
                self.repositories = []
                switch result{
                case .success(let repository):
                    self.repositories = repository.items
                case .failure(let error):
                    print(error)
                    self.repositories = []
                }
                DispatchQueue.main.async {
                    self.repositoriesDidChange()
                }
            }
            
        }
        
    }
    
    func requestRepositories(_ completion: @escaping (Result<Repository, Error>)->Void) {
        
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
    
    public enum fetchRepositorieSavedError: Error{
        case fetchFailure
        case fetchRepositoriesEmpty
        
    }
    
    func fetchSavedRepositories(_ completion: @escaping (Result<Repository, Error>)->Void){
        
        let dataManager = RepositoryDataModel.shared
        
        guard let savedRepositories = dataManager.fetch() else {
            completion(.failure(fetchRepositorieSavedError.fetchFailure))
            return
        }
        
        var repos: [Repository.Item] = []
        
        for repo in savedRepositories{
            let id = Int(repo.id)
            let name = repo.name
            let owner = Repository.Item.Owner(login: repo.login)
            let description = repo.description
            let stars = Int(repo.stargazers_count)
            let licence = Repository.Item.License(name: repo.licenseName)
            let pushed_at = repo.pushed_at
            
            let item = Repository.Item(id: id, name: name, owner: owner, description: description, stargazers_count: stars, license: licence, pushed_at: pushed_at)
            
            repos.append(item)
        }
        
        if(repos.count == 0){
            completion(.failure(fetchRepositorieSavedError.fetchRepositoriesEmpty))
            return
        }
        
        let reposityCopy = Repository(items: repos)
        
        completion(.success(reposityCopy))
        
    }
    
    @objc func segmetedControlDidChange(_ segmentedControl: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0://all repositories
            reloadTable(with: .allRepositories)
        case 1://saved repositories
//            reloadTable(with: .savedRepositories)
            print(0)
        default:
            return
        }
        
    }
}
