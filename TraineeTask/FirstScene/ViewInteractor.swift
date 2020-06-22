//
//  Interactor.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 21.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

protocol ViewBusinessLogic {
    func fetchData(reguest: List.Fetch.Request)
}

protocol ViewDataStore {
    var list: [ListModel]? { get }
}

class ViewInterator: ViewBusinessLogic,ViewDataStore {
    
    
    var presenter: ViewPresentationLogic?
    
    var listWorker = ListWorker(listStore: ServiceListStore())
    var list: [ListModel]?
    
    
    func fetchData(reguest: List.Fetch.Request) {
        listWorker.fetchLists { lists in
            self.list = lists
            let response = List.Fetch.Response(lists: lists)
            self.presenter?.presentFetchedList(response: response)
            
        }
    }
    
    
    
}
