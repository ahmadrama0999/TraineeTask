//
//  ViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 17.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myAcc = KeyChainService.service.loadAccount()
        print(myAcc)
    }
    
    @IBAction func saveAccountAction(_ sender: Any) {
        
        if let name = nameTextField.text, let surname = surnameTextField.text {
        KeyChainService.service.saveAccount(name: name, surname: surname)
        }
    }
    
}
    

