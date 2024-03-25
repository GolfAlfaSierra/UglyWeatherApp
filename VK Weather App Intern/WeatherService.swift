//
//  WeatherService.swift
//  VK Weather App Intern
//
//  Created by artyom s on 25.03.2024.
//

import Foundation

protocol CurrentWeatherServiceProtocol {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<(weather:WeatherDetail, temperature: Int, desc: String), Error>) -> Void)
}

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let visibility: Double
    let wind: Wind
    let clouds: Clouds
    
    struct Wind: Codable {
        let speed: Double
    }
    struct Weather: Codable {
        let description: String
    }
    
    struct Coord: Codable {
        let lat: Double
        let lon: Double
    }
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMax: Double
        let tempMin: Double
        let pressure: Double
        let humidity: Double
    }
    
    struct Clouds: Codable {
        let all: Double
    }
}

struct WeatherShortResponse:Codable {
    var daily: Daily
    
    struct Daily: Codable {
        let time: [String]
        let temperature2MMax: [Double]
        let temperature2MMin: [Double]
        let precipitationSum: [Double]
    }
}

protocol DaysWeatherServiceProtocol {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<[WeatherDetailShort], Error>) -> Void)
}

/*https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&forecast_days=7  */
final class OpenMeteoWeatherService: DaysWeatherServiceProtocol {
    
    
    private var urlComponent: URLComponents = {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.open-meteo.com"
        urlComponent.path = "/v1/forecast"
        urlComponent.queryItems = [
            .init(name: "daily", value: "temperature_2m_max,temperature_2m_min,precipitation_sum"),
            .init(name: "forecast_days", value: "7")
            
        ]
        return urlComponent
    }()
    
    private let session = URLSession.shared
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<[WeatherDetailShort], any Error>) -> Void) {
        urlComponent.queryItems?.append(contentsOf: [
            .init(name: "latitude", value: "\(lat)"),
            .init(name: "longitude", value: "\(lon)")
            ])
        
        guard let url = urlComponent.url else {
            print("cannot make url")
            return
        }
        
        session.dataTask(with: url) { data,response,error in
            if error == nil {} else {return}
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let jsonData = try? decoder.decode(WeatherShortResponse.self, from: data) else {
                
                return
            }
            
            
            
            
            var weathers = [WeatherDetailShort]()
            
            for n in 0..<7 {
                var weather = WeatherDetailShort()
                
                weather.dayOfWeek = jsonData.daily.time[n]
                weather.highestTemperature = "\(jsonData.daily.temperature2MMax[n])"
                weather.lowestTemperature = "\(jsonData.daily.temperature2MMin[n])"
                weather.precipiation = "\(jsonData.daily.precipitationSum[n])"
                weathers.append(weather)
            }
            completion(.success(weathers))
            
        }.resume()

        
        

    }
}



//https://api.openweathermap.org/data/2.5/weather?lat=45.058&lon=38.548&appid=e67a3af611fb752bf762e3952324a99f
final class OpenWaetherService: CurrentWeatherServiceProtocol {
    
    private var urlComponent: URLComponents = {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.openweathermap.org"
        urlComponent.path = "/data/2.5/weather"
        urlComponent.queryItems = [
            .init(name: "units", value: "metric"),
            .init(name: "appid", value: "e67a3af611fb752bf762e3952324a99f")
        ]
        return urlComponent
    }()
    private let session = URLSession.shared
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<(weather: WeatherDetail, temperature: Int, desc: String), any Error>) -> Void) {
        urlComponent.queryItems?.append(contentsOf: [
            .init(name: "lat", value: "\(lat)"),
            .init(name: "lon", value: "\(lon)")
        ])
        guard let url = urlComponent.url else {
            print("cannot make url")
            return
        }
        
        
        
        session.dataTask(with: url) { data,response,error in
            if error == nil {} else {return}
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let jsonData = try? decoder.decode(WeatherResponse.self, from: data) else {
                return
            }
            
            let model = WeatherDetail(lowestTemperature: "\(jsonData.main.tempMin)",
                                      highestTemperature: "\(jsonData.main.tempMax)",
                                      feelsLike: "\(jsonData.main.feelsLike)",
                                      pressure: "\(jsonData.main.pressure)",
                                      cloudiness: "\(jsonData.clouds.all)",
                                      visibility: "\(jsonData.visibility)",
                                      humidity: "\(jsonData.main.humidity)",
                                      windSpeed: "\(jsonData.wind.speed)")
            
            completion(.success((model, jsonData.main.temp.asInt, jsonData.weather.first!.description)))
            
        }.resume()
    }
    
    
}
