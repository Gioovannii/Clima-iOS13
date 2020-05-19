//
//  WeatherManager.swift
//  Clima
//
//  Created by mac on 2020/5/19.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=17121490b9e3ea8f4d54dc0b563f9fb2&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    
    func performRequest(urlString: String) {
        //1. Create an URL
        guard let url = URL(string: urlString) else { return }
        
        //2. Create an URLSession
        let session = URLSession(configuration: .default)
        
        //3. Give the session a task
        let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
        
        //4. Start the task
        task.resume()
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
        }
    }
}
