//
//  ViewPresenter.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 21.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

protocol ViewPresentationLogic {
    func presentFetchedList(response: List.Fetch.Response)
}

class ViewPresenter: ViewPresentationLogic{
    
    weak var viewController: ListDisplayLogic?
    
    
//    let dateFormatter: DateFormatter = {
//      let dateFormatter = DateFormatter()
//      dateFormatter.dateStyle = .short
//      dateFormatter.timeStyle = .none
//      return dateFormatter
//    }()
//
//    let currencyFormatter: NumberFormatter = {
//      let currencyFormatter = NumberFormatter()
//      currencyFormatter.numberStyle = .currency
//      return currencyFormatter
//    }()
    
    
    func presentFetchedList(response: List.Fetch.Response) {
        var displayedLists: [List.Fetch.ViewModel.DisplayedList] = []
        for list in response.lists {
            displayedLists.append(List.Fetch.ViewModel.DisplayedList(id: list.id, name: list.name))
        }
        let viewModel = List.Fetch.ViewModel(displayedList: displayedLists)
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
    
    
    
}
