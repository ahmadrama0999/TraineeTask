//
//  DataLocalService.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 28.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import CoreData
import Foundation

struct Entity: Codable {
    let id: String
    var name: String
    var age: Int
    
    init(name: String, age: Int, id: String ) {
        self.id = id
        self.name = name
        self.age = age
    }
    
    init(object: MyEntity) {
        self.id = object.id  ?? UUID().uuidString
        self.name = object.name ?? "No name"
        self.age = Int(object.age)
    }
}

protocol EntityService {
    func createEntity(entity: Entity, completion:((Entity?) -> Void)?)
    func deleteEntity(entity: Entity, completion:((Entity?) -> Void)?)
    func readEntity(completion:(([Entity]) -> Void)?)
    func updateEntity(entity: Entity, completion:((Entity?) -> Void)?)
}
struct EntityLocalService: EntityService {
    
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createEntity(entity: Entity, completion: ((Entity?) -> Void)?) {
        let someEntity = NSEntityDescription.insertNewObject(forEntityName: "MyEntity", into: context) as! MyEntity
        someEntity.id = UUID().uuidString
        someEntity.name = entity.name
        someEntity.age = Int16(entity.age)
        
        do {
            try context.save()
            completion?(entity)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteEntity(entity: Entity, completion: ((Entity?) -> Void)?) {
        let fetchRequest = NSFetchRequest<MyEntity>(entityName: "MyEntity")

        fetchRequest.predicate = NSPredicate(format: "id = '\(entity.id)'")
        do {
            let results = try context.fetch(fetchRequest)
            if let oneEntity = results.first {
                context.delete(oneEntity)
                completion?(Entity(object: oneEntity))
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readEntity(completion: (([Entity]) -> Void)?) {
        let fetchRequest = NSFetchRequest<MyEntity>(entityName: "MyEntity")
        fetchRequest.fetchBatchSize = 20
        do {
            let results = try context.fetch(fetchRequest)
            let entity = results.compactMap { Entity(object: $0)}
            completion?(entity)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateEntity(entity: Entity, completion: ((Entity?) -> Void)?) {
        let fetchRequest = NSFetchRequest<MyEntity>(entityName: "MyEntity")

        fetchRequest.predicate = NSPredicate(format: "id = '\(entity.id)'")
        do {
            let results = try context.fetch(fetchRequest)
            if let oneEntity = results.first {
                oneEntity.name = entity.name
                oneEntity.age = Int16(entity.age)
                completion?(Entity(object: oneEntity))
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
