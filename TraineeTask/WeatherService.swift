//
//  WeatherService.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 09.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

enum Utils {
    static let mainURL = "https://api.openweathermap.org/data/2.5/forecast?q="
    static let key = "&appid=acd5988b9f5c5082e4da82d86809d60e"
}

struct WeatherService {
    
    private let session = URLSession.shared
    
    func getWeather(cityName: String, completion: @escaping ((WeatherResponse) -> Void)){
        
        guard let url  = URL(string: Utils.mainURL + cityName + Utils.key) else { return }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request){ data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            switch response.statusCode {
            case 200:
                do {
                    let responseData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(responseData)
                } catch {
                    print(error.localizedDescription)
                }
            default:
                print("UNEXPECTED STATUS CODE: \(response.statusCode)")
            }
            
        }.resume()
    }
}
