//
//  WeatherService.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 09.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

struct Utils {
    static let mainURL = "https://api.openweathermap.org/data/2.5/forecast?q=London&appid="
    static let key = "acd5988b9f5c5082e4da82d86809d60e"
}

struct WeatherService {
    
    private let session = URLSession.shared
    
    func getWeather(completion: @escaping ((WeatherResponse) -> Void)){
        
        let url  = URL(string: Utils.mainURL + Utils.key)
        var request = URLRequest(url:url!)
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
                    //print(responseData)
                    //DispatchQueue.main.async {
                        completion(responseData)
                    //}
                    
                } catch {
                    print(error.localizedDescription)
                }
            default:
                print("UNEXPECTED STATUS CODE: \(response.statusCode)")
            }
            
        }.resume()
    }
}
