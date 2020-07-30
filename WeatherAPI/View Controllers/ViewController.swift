//
//  ViewController.swift
//  WeatherAPI
//
//  Created by yurik on 7/23/20.
//  Copyright © 2020 yurik. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
   
    //создаем ленивую переменную определения местоположения
    lazy var locationManager: CLLocationManager = {
       // создание экземпляра класса CLLocationManager
        let lm = CLLocationManager()
        //объявляем ViewController делегатом lm (CLLocationManager)
        lm.delegate = self
        
        //определение точности положения
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        //запрос пользователя к доступу его геопозиции
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    @IBAction func searchPressed(_ sender: UIButton) {
       
       
        presentSearchAlertController(withTitle: "Enter city Name", message: nil, style: .alert) { [unowned self](city) in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard  let self = self else {return}
            self.updateInterfaceWith(weather: currentWeather)
            
        }
       
      //networkWeatherManager.fetchWeather(forCity: "Kyiv")
      //общие настройки геопозиции
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
        }
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

//подписываем ViewController под протокол CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
