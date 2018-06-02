//
//  VivoService.swift
//  VivoFinder
//
//  Created by developersancho on 2.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import Foundation

class VivoService {
    let vivoBaseURL: URL?
    
    init() {
        vivoBaseURL = URL(string: "https://http://api.developersancho.com/v1/vivos/all/distance/")
    }
    
//    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void)
//    {
//        if let forecastURL = URL(string: "\(forecastBaseURL!)/\(latitude),\(longitude)") {
//            
//            Alamofire.request(forecastURL).responseJSON(completionHandler: { (response) in
//                if let jsonDictionary = response.result.value as? [String : Any] {
//                    if let currentWeatherDictionary = jsonDictionary["currently"] as? [String : Any] {
//                        let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
//                        completion(currentWeather)
//                        print(currentWeather.temperature ?? 2)
//                    } else {
//                        completion(nil)
//                    }
//                }
//            })
//        }
//        
//    }
}
