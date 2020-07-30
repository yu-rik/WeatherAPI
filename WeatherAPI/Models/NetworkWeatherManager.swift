//
//  NetworkWeatherManager.swift
//  WeatherAPI
//
//  Created by yurik on 7/24/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit
import CoreLocation


class NetworkWeatherManager{
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    //передача данных через closure созданный как свойство
    //создаем closure onCopletion(дополнительный CompletionHandler,который дает возможность подписаться под изменения currentWeather
   var onCompletion:((CurrentWeather) -> Void)?
     
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat={\(latitude)}&lon={\(longitude)}&apikey=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
//    // метод получения погоды по названию города
//    func fetchWeather(forCity city: String) {
//        //метод для получения JSON данных
//        let urlString = "api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
//        performRequest(withURLString: urlString)
//
//    }
//
//    // метод получения погоды по координатам
//   func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        //метод для получения JSON данных
//        let urlString = //api.openweathermap.org/data/2.5/weather?lat={\(latitude)}&lon={\(longitude)}&apikey=\(apiKey)&units=metric"
//
//       performRequest(withURLString: urlString)
//
//
//    }
    
    fileprivate func performRequest(withURLString urlString: String){
        //создаем URL-строку
        guard let url = URL(string: urlString)else {return}
        
        //создаем URL-сессию
        let session = URLSession(configuration: .default)
        
        //сооздаем запрос данных
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data{
                
                // let dataString = String(data: data, encoding: .utf8)
                //print(dataString!) //раcпечатает JSON данные
                if let currentWeather = self.parseJSON(withData: data){
                   
                    //передаем currentWeather через onCompletion
                    self.onCompletion?(currentWeather)
                }
            }
        }
        //чтоб произошел запрос - вызываем resume()
        task.resume()
    }
    
    
    
    //метод который распарсит JSON-данные(расскладывает полученные данные по модели которую создали
   fileprivate func parseJSON(withData data: Data) -> CurrentWeather?{
        let decoder = JSONDecoder()//создаем декодер
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            
            //создаем объект CurrentWeather
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {return nil}
            return currentWeather
            
            //  print(currentWeatherData.main.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
