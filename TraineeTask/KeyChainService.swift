//
//  KeyChainService.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 08.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation
import Locksmith


class KeyChainService {
    
    static let service = KeyChainService()
    
    private init() { }
    
    
    func saveAccount(name: String, surname: String) {
        do {
            try Locksmith.saveData(data: ["name" : name, "surname" : surname], forUserAccount: "MyAcc")
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    func loadAccount() -> [String : Any]?  {
           return Locksmith.loadDataForUserAccount(userAccount: "MyAcc")
    }
    
}
