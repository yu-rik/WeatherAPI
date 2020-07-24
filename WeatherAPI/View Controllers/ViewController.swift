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
    
    let networkWeatherManager = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
       
        presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        networkWeatherManager.fetchWeather(forCity: "Kyiv")
    }


}

