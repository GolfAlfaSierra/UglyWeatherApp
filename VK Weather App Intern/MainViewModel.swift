//
//  MainViewModel.swift
//  VK Weather App Intern
//
//  Created by artyom s on 24.03.2024.
//

import UIKit

struct MainViewState {
    var cityName: String = "N/A"
    var temperature: String = "N/A"
    var weatherDescription: String = "N/A"
    var lon: String = "N/A"
    var lat: String = "N/A"
    
    var weatherDetail: WeatherDetail
    var weatherDetailShort = [WeatherDetailShort]()
}
struct WeatherDetail {
    var lowestTemperature: String = "N/A"
    var highestTemperature: String = "N/A"
    var feelsLike: String = "N/A"
    var pressure: String = "N/A"
    var cloudiness: String = "N/A"
    
    var visibility: String = "N/A"
    var humidity: String = "N/A"
    var windSpeed: String = "N/A"
}

struct WeatherDetailShort {
    var dayOfWeek:String = "N/A"
    var temperature:String = "N/A"
    var lowestTemperature:String = "N/A"
    var highestTemperature:String = "N/A"
    var precipiation: String = "N/A"
}


