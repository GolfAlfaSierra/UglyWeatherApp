//
//  MainViewPresenter.swift
//  VK Weather App Intern
//
//  Created by artyom s on 25.03.2024.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    var didReciveCordinates: ((Double,Double) -> ())? { get set }
}

final class MainViewPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var weatherService: CurrentWeatherServiceProtocol
    var dailyWeatherService: DaysWeatherServiceProtocol
    
    var locationService: LocationServiceProtocol
    
    init(view: MainViewProtocol?, weatherService: CurrentWeatherServiceProtocol, locationService: LocationServiceProtocol, dailyWeatherService: DaysWeatherServiceProtocol) {
        self.view = view
        self.weatherService = weatherService
        self.locationService = locationService
        self.dailyWeatherService = dailyWeatherService
        
    }
    func viewDidLoad() {
        
        
        locationService.didReciveCordinates = {[ weak view] lat, lon in
            view?.didRecieveLocation(lat: lat, lon: lon)
            CLLocation(latitude: lat, longitude: lon).fetchCityAndCountry { city, country, error in
                if let city = city {
                    view?.didRecieveCityName(name: city)
                } else {view?.didRecieveCityName(name: "unkonwn")}
                
            }
            
            
            self.weatherService.fetchWeather(lat: lat, lon: lon) { [weak view] result in
                print("weatherserivce")
                switch result {
                case .success(let success):
                    view?.didRecieveWeather(weatherData: success.weather)
                    view?.didRecieveTemperature(temperature: success.temperature)
                    view?.didRecieveTemperatureDescription(desc: success.desc)
                    
                case .failure(_):
                    break
                }
            }
            
            self.dailyWeatherService.fetchWeather(lat: lat, lon: lon, completion: { [weak view] result in
                switch result {
                case .success(let success):
                    view?.didReciveDailyWeather(weathers: success)
                case .failure(_):
                    break
                }
            })
            
            
        }
        
        
        
    }
    
   
    
   
}
