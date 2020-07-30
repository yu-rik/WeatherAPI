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
       // return "\(temperature.rounded())"
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeString: String {
       return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemWeatherIcon: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "tornado"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
            
        default:
            return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData){
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
        
    }
}
