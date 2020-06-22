//
//  ListWirker.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 22.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

protocol ListStoreProtocol {
    //MARK: CRUD OPERATIONS
    func fetchLists(completionHandler: @escaping (() throws -> [ListModel]) -> Void)
//    func fetchOrder(id: String, completionHandler: @escaping (() throws -> ListModel?) -> Void)
//    func createOrder(orderToCreate: ListModel, completionHandler: @escaping (() throws -> ListModel?) -> Void)
//    func updateOrder(orderToUpdate: ListModel, completionHandler: @escaping (() throws -> ListModel?) -> Void)
//    func deleteOrder(id: String, completionHandler: @escaping (() throws -> ListModel?) -> Void)
}

enum OrdersStoreError: Equatable, Error
{
  case CannotFetch(String)
  case CannotCreate(String)
  case CannotUpdate(String)
  case CannotDelete(String)
}

class ListWorker {

    var listStore: ListStoreProtocol

    init(listStore: ListStoreProtocol) {
        self.listStore = listStore
    }
    
    func fetchLists(completionHandler: @escaping ([ListModel]) -> Void)
    {
      listStore.fetchLists { (lists: () throws -> [ListModel]) -> Void in
        do {
          let lists = try lists()
          DispatchQueue.main.async {
            completionHandler(lists)
          }
        } catch {
          DispatchQueue.main.async {
            completionHandler([])
          }
        }
      }
    }
    
//    func createOrder(orderToCreate: ListModel, completionHandler: @escaping (ListModel?) -> Void)
//    {
//      listStore.createOrder(orderToCreate: orderToCreate) { (order: () throws -> ListModel?) -> Void in
//        do {
//          let order = try order()
//          DispatchQueue.main.async {
//            completionHandler(order)
//          }
//        } catch {
//          DispatchQueue.main.async {
//            completionHandler(nil)
//          }
//        }
//      }
//    }
//    
//    func updateOrder(orderToUpdate: ListModel, completionHandler: @escaping (ListModel?) -> Void)
//    {
//      listStore.updateOrder(orderToUpdate: orderToUpdate) { (order: () throws -> ListModel?) in
//        do {
//          let order = try order()
//          DispatchQueue.main.async {
//            completionHandler(order)
//          }
//        } catch {
//          DispatchQueue.main.async {
//            completionHandler(nil)
//          }
//        }
//      }
//    }

}


