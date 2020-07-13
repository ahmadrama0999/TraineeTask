//
//  CirclePresenter.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 13.07.2020.
//  Copyright (c) 2020 Ramin Akhmad. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CirclePresentationLogic
{
  func presentSomething(response: Circle.Something.Response)
}

class CirclePresenter: CirclePresentationLogic
{
  weak var viewController: CircleDisplayLogic?
  
  
  func presentSomething(response: Circle.Something.Response)
  {
    
    let list = Array(response.weatherData[0].list.prefix(11))
    var temp = [Double]()
    var description = [String]()
    list.forEach { (item) in
        temp.append(item.main.temp)
        description.append(item.weather[0].main.rawValue)
    }
    let viewModel = Circle.Something.ViewModel(cityName: response.weatherData[0].city.name, temp: temp, weatherDescription: description)
    viewController?.displayWeather(viewModel: viewModel)
  }
}
