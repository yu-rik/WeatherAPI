//
//  ViewController+Alert.swift
//  WeatherAPI
//
//  Created by yurik on 7/23/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping(String) -> Void){
        //создаем АлертКонтроллер и передаем значения из параметров метода
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        //создаем текстовое поле в Алерт-Контроллере
        ac.addTextField { (tf) in
            let cities = ["Kyiv", "Lviv", "Odessa", "Kharkiv", "Chernigiv", "Yalta", "Donetsk"]
            tf.placeholder = cities.randomElement()
        }
        //создаем кнопки
        let search = UIAlertAction(title: "Search", style: .default) { (action) in
            let textFD = ac.textFields?.first
            guard let cityName = textFD?.text else {return}
            if cityName != "" {
               // print("search info for the \(cityName)")
                //self.networkWeatherManager.fetchWeather(forCity: cityName)
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //добавляем кнопки Алерт-Контроллеру
        ac.addAction(search)
        ac.addAction(cancel)
        
        //показываем Алерт-Контроллер
        present(ac, animated: true, completion: nil)
    }
}

