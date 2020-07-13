////
////  ViewController.swift
////  TraineeTask
////
////  Created by Ramin Akhmad on 17.06.2020.
////  Copyright © 2020 Ramin Akhmad. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    
//    @IBOutlet weak var cityLabel: UILabel!
//    @IBOutlet weak var startButton: UIButton!
//    
//    private var arrayData = [WeatherResponse]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        CircleView.circle.center = self.view.center
//        view.addSubview(CircleView.circle)
//        
//        WeatherService().getWeather { ( response ) in
//            self.arrayData.removeAll()
//            self.arrayData.append(response)
//            DispatchQueue.main.async {
//                self.cityLabel.text = self.arrayData[0].city.name
//                self.cityLabel.isHidden = false
//            }
//        }
//    }
//    
//    @IBAction func startAction(_ sender: Any) {
////        CircleView.circle.start(weatherResponse: self.arrayData)
//    }
//}
