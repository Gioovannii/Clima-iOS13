//
//  WeatherData.swift
//  Clima
//
//  Created by mac on 2020/5/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}

