//
//  HeaderView.swift
//  VK Weather App Intern
//
//  Created by artyom s on 23.03.2024.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let resueId = String(describing: HeaderView.self)
    
    let dateLabel = UILabel().style(labelStyle: .dateLabelStyle)
    let cityNameLabel = UILabel().style(labelStyle: .cityNameLabelStyle)
    let temperatureLabel = UILabel().style(labelStyle: .temperatureLabelStyle)
    let weatherDescriptionLabel = UILabel().style(labelStyle: .weatherDescriptionLabelStyle)
    let latitudeLabel =  UILabel().style(labelStyle: .coordinateLabelStyle)
    let longitudeLabel = UILabel().style(labelStyle: .coordinateLabelStyle)
    
    let weatherDetailView = WeatherDetailView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .background// TODO: remove
        configure()
        
        setState(date: Date())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setState(date: Date? = nil,
                  cityName: String? = nil,
                  temperature: String? = nil,
                  weatherDescription: String? = nil,
                  lat: Double? = nil,
                  lon:Double? = nil) {
        
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
        }
        
        if let cityName = cityName {
            cityNameLabel.text = cityName
        }
        
        
        if let temperature = temperature {
            temperatureLabel.text = temperature
        }
        
        
        if let weatherDescription = weatherDescription {
            weatherDescriptionLabel.text = weatherDescription
        }
        
        if let latitude = lat {
            latitudeLabel.text = "lat: \(latitude)"
        }
        
        
        if let longitude = lon {
            longitudeLabel.text = "lon: \(longitude)"
        }
    }
    
    private func configure() {
        dateLabel.text               = "Thu, 21 Mar 2024 99:50"
        cityNameLabel.text           = "Sochi"
        temperatureLabel.text        = "32°"
        weatherDescriptionLabel.text = "Weather description"
        latitudeLabel.text           =  "lat: 40.20132312"
        longitudeLabel.text          = "lon: 40.1231233"
        
        
        [dateLabel,
         cityNameLabel,
         temperatureLabel,
         weatherDescriptionLabel,
         latitudeLabel,
         longitudeLabel,
         weatherDetailView].forEach({addSubview($0);$0.translatesAutoresizingMaskIntoConstraints = false})
        
        let padding: CGFloat = 8
        
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            cityNameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            cityNameLabel.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: cityNameLabel.centerXAnchor),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: padding),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: temperatureLabel.centerXAnchor),
            
            latitudeLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: padding),
            latitudeLabel.centerXAnchor.constraint(equalTo: weatherDescriptionLabel.centerXAnchor),
            
            longitudeLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor),
            longitudeLabel.leadingAnchor.constraint(equalTo: latitudeLabel.leadingAnchor),
            
            weatherDetailView.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 8),
            weatherDetailView.centerXAnchor.constraint(equalTo: centerXAnchor)
            
            
        ])
    }
}

final class WeatherDetailView: UIView {
    private let lowestHighestTemperatureLabel = WeatherItem(title: "Temperature", value: "10° / 12°")
    private let seaLevelLabel = WeatherItem(title: "SeaLevel", value: "10 m")
    private let pressureLabel = WeatherItem(title: "Pressure", value: "744hg")
    
    private let cloudinessLabel = WeatherItem(title: "Cloudiness", value: "10%")
    private let feelsLikeLabel = WeatherItem(title: "Feels Like", value: "32°")
    private let precipiationLabel = WeatherItem(title: "Precipiation", value: "0 mm")
    
    private let visibilityLabel = WeatherItem(title: "Visibility", value: "10km")
    private let humidityLabel = WeatherItem(title: "Humidity", value: "40%")
    private let windLabel = WeatherItem(title: "Wind", value: "12 m/s")
    
    var weatherItemsStackview = UIStackView()
    
    private let detailContainerView = UIView()
    private let shadowView = ShadowView()
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setState(lowestTemperature: Int? = nil,
                  highestTemperature: Int? = nil,
                  seaLevel: Int? = nil,
                  pressure: Int? = nil,
                  cloudiness: Int? = nil,
                  feelsLike: Int? = nil,
                  precipitation: Int? = nil,
                  visibility: Int? = nil,
                  windSpeed: Int? = nil) {
        
        if let lowestTemperature = lowestTemperature, let highestTemperature = highestTemperature {
                lowestHighestTemperatureLabel.setState(
                    "\(lowestTemperature)° / \(highestTemperature)°")
            }
            
            if let seaLevel = seaLevel {
                seaLevelLabel.setState( "\(seaLevel) m" )
            }
            
            if let pressure = pressure {
                pressureLabel.setState( "\(pressure)hg" )
            }
            
            if let cloudiness = cloudiness {
                cloudinessLabel.setState( "\(cloudiness)% )")
            }
            
            if let feelsLike = feelsLike {
                feelsLikeLabel.setState( "\(feelsLike)°" )
            }
            
            if let precipitation = precipitation {
                precipiationLabel.setState("\(precipitation) mm")
            }
            
            if let visibility = visibility {
                visibilityLabel.setState("\(visibility)m")
            }
            
            if let windSpeed = windSpeed {
                windLabel.setState("\(windSpeed) m )/s")
            }
        
    }
    
    private func configure() {
        addSubview(shadowView)
        shadowView.addSubview(detailContainerView)
        detailContainerView.addSubview(weatherItemsStackview)
        
        makeStackviews()
        makeConstraints()
        
        detailContainerView.backgroundColor = .white
        detailContainerView.layer.cornerRadius = 10
        shadowView.layer.cornerRadius = detailContainerView.layer.cornerRadius
    }
    
    private func makeStackviews() {
        
        weatherItemsStackview.alignment = .center
        weatherItemsStackview.distribution = .equalSpacing
        weatherItemsStackview.spacing = 16
        
        let column1 = UIStackView(arrangedSubviews: [
            lowestHighestTemperatureLabel, seaLevelLabel, pressureLabel])
        let column2 = UIStackView(arrangedSubviews: [
            cloudinessLabel, feelsLikeLabel, precipiationLabel])
        let column3 = UIStackView(arrangedSubviews: [
            visibilityLabel, humidityLabel, windLabel])
        
        [column1, column2, column3].forEach { column in
            column.spacing = 40
            column.axis = .vertical
            weatherItemsStackview.addArrangedSubview(column)
        }
        
    }
    
    func makeConstraints() {
        
        shadowView.pinToEdges()
        detailContainerView.pinToEdges()
        weatherItemsStackview.pinToEdges(withInset: .init(top: 24, left: 24, bottom: 24, right: 24))
        
    }
}

