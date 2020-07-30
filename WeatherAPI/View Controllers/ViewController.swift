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
       
       
        presentSearchAlertController(withTitle: "Enter city Name", message: nil, style: .alert) { [unowned self](city) in
            self.networkWeatherManager.fetchWeather(forCity: city)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard  let self = self else {return}
            self.updateInterfaceWith(weather: currentWeather)
            
        }
       
      networkWeatherManager.fetchWeather(forCity: "Kyiv")
    }
//метод обновления интерфейса по конкретной погоде
    func updateInterfaceWith(weather: CurrentWeather){
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeLabel.text = weather.feelsLikeString
            self.cityLabel.text = weather.cityName
            self.weatherImage.image = UIImage(systemName: weather.systemWeatherIcon)
        }
    }

}

