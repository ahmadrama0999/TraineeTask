//
//  CoreDataService.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 23.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit
import CoreData


struct CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {}
    
    func createData(cityName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let userEntity = NSEntityDescription.entity(forEntityName: "CityEntity", in: managedContext) else { return }
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(cityName, forKey: "name")
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("Could not save \(error)")
        }
    }
    
    func readData() -> [String]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [""]}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>( entityName: "CityEntity")
        
        do {
            let data = try managedContext.fetch(fetchRequest)
            var result = [String]()
            for item in data  as! [NSManagedObject] {
                //                print(item.value(forKey: "name"))
                result.append(item.value(forKey: "name") as? String ?? "Unknown data")
            }
            
            return result
        } catch {
            fatalError("Couldn't read data, cause \(error)")
        }
    }
    
    //    func deleteData() {
    //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    //        let managedContext = appDelegate.persistentContainer.viewContext
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>( entityName: "CityEntity")
    //        fetchRequest.predicate = NSPredicate(
    //    }
    
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CityEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try appDelegate.persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            fatalError("Cant delete all \(error)")
        }
    }
    
    
}
