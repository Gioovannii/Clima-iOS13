//
//  WeatherManager.swift
//  Clima
//
//  Created by mac on 2020/5/19.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=17121490b9e3ea8f4d54dc0b563f9fb2&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create an URL
        guard let url = URL(string: urlString) else { return }
        
        //2. Create an URLSession
        let session = URLSession(configuration: .default)
        
        //3. Give the session a task
        let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if  let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
        //4. Start the task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder =  JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id =  decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            print("error")
            return nil
        }
    }
}

