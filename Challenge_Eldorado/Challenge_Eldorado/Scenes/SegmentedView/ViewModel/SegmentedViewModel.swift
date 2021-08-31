//
//  SegmentedViewModel.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/08/21.
//

import UIKit

class SegmentedViewModel {
    
    let segmentedViews = ["All", "Saved"]
    let title = "Swift Repositories"
    var repositories: [Repository.Item] = []
    
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
    
    @objc func segmetedControlDidChange(_ segmentedControl: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0://all repositories
            print(0)
        case 1://saved repositories
            print(1)
        default:
            return
        }
        
    }
}
