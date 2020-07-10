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
        
        //        let box = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        //        box.backgroundColor = .red
        //        view.addSubview(box)
    }
    
    @IBAction func startAction(_ sender: Any) {
        CircleView.circle.start()
        WeatherService().getWeather { ( response ) in
            self.arrayData.append(response)
        }
        print(arrayData)
        
    }
}
