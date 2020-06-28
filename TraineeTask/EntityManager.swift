//
//  EntityManager.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 28.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation


class EntityManager {
    
    
    static let shared = EntityManager()
    
    private var service: EntityService {
        return EntityLocalService.init(context: Utils.appDelegate.persistentContainer.viewContext)
    }
    
    
    func create(name:String, age: Int, completion: @escaping ((Entity?) -> Void)) {
        service.createEntity(entity: Entity(name: name, age: age, id: ""), completion: completion)
    }
    
    func delete(entity: Entity) {
        service.deleteEntity(entity: entity, completion: nil)
    }
    
    func read(completion: @escaping (([Entity]) -> Void)) {
        service.readEntity(completion: completion)
    }
    
    
    func update(entity: Entity, completion: ((Entity?) -> Void)?) {
        service.updateEntity(entity: entity, completion: completion)
    }
    
    
}
