//
//  CityTableInteractor.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 14.07.2020.
//  Copyright (c) 2020 Ramin Akhmad. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CityTableBusinessLogic
{
    func fetchData(request: CityTable.CityList.Request)
     func fetchFiltereData(searchName: String)
}

protocol CityTableDataStore
{
    var cities: [String]? { get }
}

class CityTableInteractor: CityTableBusinessLogic, CityTableDataStore
{
    var cities: [String]?
    var presenter: CityTablePresentationLogic?
    var worker: CityTableWorker?
    
    // MARK: Do something
    
    func fetchData(request: CityTable.CityList.Request) {
        worker = CityTableWorker()
        cities = worker?.fetchCities()
        guard let list = cities else { return }
        let response = CityTable.CityList.Response(cities: list)
        presenter?.presentSomething(response: response)
    }
    
    func fetchFiltereData(searchName: String) {
        var dispCities = [String]()
        guard let list = cities else { return }
        if searchName == "" {
            dispCities = list
        } else {
            dispCities = list.filter { $0.range(of: searchName, options: .caseInsensitive) != nil }
        }
        presenter?.presentSomething(response: CityTable.CityList.Response(cities: dispCities))
    }
}
