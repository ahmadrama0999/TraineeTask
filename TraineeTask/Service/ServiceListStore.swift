//
//  Service.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 22.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

class ServiceListStore: ListStoreProtocol {
    
    static var lists: [ListModel] = [ListModel(id:"123",name:"Ram"),
                                     ListModel(id: "111", name: "Sasha")]

    func fetchLists(completionHandler: @escaping (() throws -> [ListModel]) -> Void)
    {
      completionHandler { return type(of: self).lists }
    }
    

//    func fetchOrder(id: String, completionHandler: @escaping (() throws -> ListModel?) -> Void) {
//        <#code#>
//    }
//
//    func createOrder(orderToCreate: ListModel, completionHandler: @escaping (() throws -> ListModel?) -> Void) {
//        <#code#>
//    }
//
//    func updateOrder(orderToUpdate: ListModel, completionHandler: @escaping (() throws -> ListModel?) -> Void) {
//        <#code#>
//    }
//
//    func deleteOrder(id: String, completionHandler: @escaping (() throws -> ListModel?) -> Void) {
//        <#code#>
//    }


}
