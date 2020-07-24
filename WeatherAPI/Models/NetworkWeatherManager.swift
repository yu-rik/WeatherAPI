//
//  NetworkWeatherManager.swift
//  WeatherAPI
//
//  Created by yurik on 7/24/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import Foundation
struct NetworkWeatherManager {
    func fetchWeather(forCity city: String) {
        //метод для получения JSON данных
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)"
        //создаем URL-строку
        guard let url = URL(string: urlString)else {return}
        
        //создаем URL-сессию
        let session = URLSession(configuration: .default)
        
        //сооздаем запрос данных
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data{
                
               // let dataString = String(data: data, encoding: .utf8)
                //print(dataString!) //раcпечатает JSON данные
               let currentWeather = self.parseJSON(withData: data)
            }
        }
        //чтоб произошел запрос - вызываем resume()
        task.resume()
    }
     
    //метод который распарсит JSON-данные(расскладывает полученные данные по модели которую создали
    func parseJSON(withData data: Data) -> CurrentWeather?{
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
