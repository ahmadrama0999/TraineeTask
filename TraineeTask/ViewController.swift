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
    
    
    var array: [String] = ["Ramin", "Alex", "Misha", "Viktor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        print("STRUCT")
        var studentS1 = StudentStruct()
        print("S1" ,studentS1)
        let studentS2 = studentS1
        print("S2",studentS2)
        studentS1.name = "Rama"
        print("S1",studentS1)
        print("S2",studentS2)
        
        print("Class")
        let studentC1 = StudentClass()
        print("C1" ,studentC1.name)
        let studentC2 = studentC1
        print("C2" ,studentC2.name)
        studentC1.name = "Dani"
        print("C1",studentC1.name)
        print("C2",studentC2.name)
        
        
        
    }
    
    @IBAction func sortCellAction(_ sender: Any) {
        array.sort { (s1, s2) -> Bool in
            return s1<s2
        }
        tableView.reloadData()
    }
}
    

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell") else { return UITableViewCell()}
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
}

struct StudentStruct {
    var name = "Vika"
}

class StudentClass {
    var name = "Viktor"
}

