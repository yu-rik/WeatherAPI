//
//  ViewController.swift
//  WeatherAPI
//
//  Created by yurik on 7/23/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
       
       // presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert)
        presentSearchAlertController(withTitle: "Enter city Name", message: nil, style: .alert) { (city) in
            self.networkWeatherManager.fetchWeather(forCity: city)
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //чтоб viewController был связан с networkWeatherManager мы должны объявить viewController как делегат от networkWeatherManager
       networkWeatherManager.delegate = self
        
     //   networkWeatherManager.onCompletion = {
        //    currentWeather in
        //    print(currentWeather.cityName)
      //  }
       
       
       // networkWeatherManager.fetchWeather(forCity: "Kyiv")
    }


}
//чтоб viewController был делегатом NetworkWeatherManagerDelegate подписываем его под этот протокол
extension ViewController: NetworkWeatherManagerDelegate{
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather) {
        //обновление интерфейса
        print(currentWeather.cityName)
    }
    
    
}
