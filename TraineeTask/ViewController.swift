//
//  ViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 17.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
    

// Example of using GENERIC
struct Stack <Element> {
    var values = [Element]()
    
    mutating func push(value: Element) {
        values.append(value)
    }
    
    mutating func pop() {
        values.removeLast()
    }
}

struct Queue <Element> {
    var values = [Element]()
    
    mutating func add(value: Element) {
        values.append(value)
    }
    
    mutating func remove() {
        values.removeFirst()
    }
}
