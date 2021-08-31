//
//  RepositoryDataManager.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 31/08/21.
//

import Foundation
import CoreData

internal struct RepositoryDataModel{
    static let shared = RepositoryDataModel()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Challenge_Eldorado")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("erro de load \(error)")
            }
        }
        return container
    }()
    
    func create(_ localModel: LocalRepositoryModel) -> LocalRepository? {
        
        let context = persistentContainer.viewContext
        let localRepository = NSEntityDescription.insertNewObject(forEntityName: "LocalRepository", into: context) as! LocalRepository
        
        localRepository.id = Int64(localModel.id ?? 0)
        localRepository.descriptionItem = localModel.descriptionItem
        localRepository.licenseName = localModel.licenseName
        localRepository.login = localModel.login
        localRepository.name = localModel.name
        localRepository.pushed_at = localModel.pushed_at
        localRepository.stargazers_count = Int64(localModel.stargazers_count ?? 0)
        
        do {
            try context.save()
            return localRepository
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    func fetch() -> [LocalRepository]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<LocalRepository>(entityName: "LocalRepository")
        
        do{
            let localRepository = try context.fetch(fetchRequest)
            return localRepository
        } catch let error{
            print(error)
        }
        return nil
    }
    
    func exist(idRepository: Int?)->Bool{
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<LocalRepository>(entityName: "LocalRepository")
        guard let idRepository = idRepository else { return false }
        
        do{
            let repository = try context.fetch(fetchRequest)
            return repository.contains { repo in
                return repo.id == idRepository
            }
            
        } catch let error{
            print(error)
        }
        return false
        
    }
    
    func delete(localModel: LocalRepositoryModel){
        let context = persistentContainer.viewContext
        
        let localRepository = NSEntityDescription.insertNewObject(forEntityName: "LocalRepository", into: context) as! LocalRepository
        
        localRepository.id = Int64(localModel.id ?? 0)
        localRepository.descriptionItem = localModel.descriptionItem
        localRepository.licenseName = localModel.licenseName
        localRepository.login = localModel.login
        localRepository.name = localModel.name
        localRepository.pushed_at = localModel.pushed_at
        localRepository.stargazers_count = Int64(localModel.stargazers_count ?? 0)
        
        context.delete(localRepository)
        do{
            try context.save()
        } catch let deleteError {
            print("Failed to delete: \(deleteError)")
        }
    }
    
}
