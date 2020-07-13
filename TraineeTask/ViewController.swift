//
//  ViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 17.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    private var arrayData = [WeatherResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CircleView.circle.center = self.view.center
        view.addSubview(CircleView.circle)
    }
    
    @IBAction func startAction(_ sender: Any) {
        CircleView.circle.start()
        WeatherService().getWeather { ( response ) in
            self.arrayData.removeAll()
//            DispatchQueue.main.async {
//                self.arrayData.append(response)
//            }
            self.arrayData.append(response)
            print(self.arrayData.count)

        }
        print(arrayData)
        
    }
}
