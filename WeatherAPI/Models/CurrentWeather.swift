//
//  CurrentWeather.swift
//  WeatherAPI
//
//  Created by yurik on 7/24/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import Foundation
// модель для отображения данных в интерфейсе
struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData){
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
        
    }
}
