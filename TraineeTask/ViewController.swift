//
//  ViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 17.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var entityArray: [Entity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateList()
    }
    
    func updateList() {
        EntityManager.shared.read{ entity in
            self.entityArray = entity
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func addEntityAction(_ sender: Any) {
//        CarManager.shared.saveCar(title: titleTextField.text ?? "NO name",
//                                  wasInAccident: wasInAccidentSwitch.isOn,
//                                  productionYear: productionYearTextField.text) { _ in
//                                    self.didSaveObject?()
//                                    self.dismiss(animated: true)
//                                    print("CAR IS CREATED")
//        }
        EntityManager.shared.create(name: "Test", age: 123) { _ in
            print("Entity Created")
        }
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = entityArray[indexPath.row]
        cell.textLabel!.text = object.name
        cell.detailTextLabel?.text = String(object.age)
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
    
