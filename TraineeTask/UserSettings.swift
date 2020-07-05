//
//  UserDefaults.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 05.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

 final class UserSettings {
    
    
    private enum SettingsKeys: String {
        case userModel
    }
    
    static var userModel : Student? {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Student else { return nil }
            return decodedModel
        }
        set {
            let key = SettingsKeys.userModel.rawValue
            let shared = UserDefaults.standard
            
            if let user = newValue {
                if let savedUser = try? NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false) {
                    shared.set(savedUser, forKey: key)
                } else {
                    shared.removeObject(forKey: key)
                }
            }
        }
    }

}
