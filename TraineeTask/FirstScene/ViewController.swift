//
//  ViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 17.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

protocol ListDisplayLogic: class
{
  func displayFetchedOrders(viewModel: List.Fetch.ViewModel)
}


class ViewController: UIViewController, ListDisplayLogic{
    
    @IBOutlet weak var tableView: UITableView!
    var interactor: ViewBusinessLogic?
    
    var displayedLists: [List.Fetch.ViewModel.DisplayedList] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    private func setup() {

        let viewController = self
        let interactor = ViewInterator()
        let presenter = ViewPresenter()
        let router = ViewRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchLists()
    }
    
    func fetchLists() {
        let request = List.Fetch.Request()
        interactor?.fetchData(reguest: request)
    }
    func displayFetchedOrders(viewModel: List.Fetch.ViewModel) {
        displayedLists = viewModel.displayedList
        tableView.reloadData()
       }
       
    
}


extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else { return UITableViewCell()}
        cell.nameLabel.text = displayedLists[indexPath.row].name
        return cell
    }
    
}

