//
//  HeaderView.swift
//  VK Weather App Intern
//
//  Created by artyom s on 23.03.2024.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let resueId = String(describing: HeaderView.self)
    
    let cityNameLabel = UILabel().style(labelStyle: .cityNameLabelStyle)
    let temperatureLabel = UILabel().style(labelStyle: .temperatureLabelStyle)
    let weatherDescriptionLabel = UILabel().style(labelStyle: .weatherDescriptionLabelStyle)
    let latitudeLabel =  UILabel().style(labelStyle: .coordinateLabelStyle)
    let longitudeLabel = UILabel().style(labelStyle: .coordinateLabelStyle)
    
    let weatherDetailView = WeatherDetailView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setState(
                  cityName: String? = nil,
                  temperature: String? = nil,
                  weatherDescription: String? = nil,
                  lat: Double? = nil,
                  lon:Double? = nil,
                  weatherDetail: WeatherDetail
    ) {
        if let cityName = cityName {
            cityNameLabel.text = cityName
        }
        
        
        if let temperature = temperature {
            temperatureLabel.text = "\(temperature)º"
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
        
        self.weatherDetailView.setState(
            lowestTemperature: Double(weatherDetail.lowestTemperature),
            highestTemperature: Double(weatherDetail.highestTemperature),
            pressure: Double(weatherDetail.pressure),
            cloudiness: Double(weatherDetail.cloudiness),
            feelsLike: Double(weatherDetail.feelsLike),
            visibility: Double(weatherDetail.visibility),
            windSpeed: Double(weatherDetail.windSpeed),
            humidity: Double(weatherDetail.humidity)
        )
    }
    
    private func configure() {
        [
         cityNameLabel,
         temperatureLabel,
         weatherDescriptionLabel,
         latitudeLabel,
         longitudeLabel,
         weatherDetailView].forEach({addSubview($0);$0.translatesAutoresizingMaskIntoConstraints = false})
        
        let padding: CGFloat = 8
        
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
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
    private let lowestHighestTemperatureLabel = WeatherItemView(title: "Low / High", value: "N/A")
    
    private let pressureLabel = WeatherItemView(title: "Pressure", value: "N/A")
    
    private let cloudinessLabel = WeatherItemView(title: "Cloudiness", value: "N/A")
    private let feelsLikeLabel = WeatherItemView(title: "Feels Like", value: "N/A")
    
    
    private let visibilityLabel = WeatherItemView(title: "Visibility", value: "N/A")
    private let humidityLabel = WeatherItemView(title: "Humidity", value: "N/A")
    private let windLabel = WeatherItemView(title: "Wind", value: "N/A")
    
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
    
    func setState(lowestTemperature: Double? = nil,
                  highestTemperature: Double? = nil,
                  pressure: Double? = nil,
                  cloudiness: Double? = nil,
                  feelsLike: Double? = nil,
                  visibility: Double? = nil,
                  windSpeed: Double? = nil,
                  humidity: Double? = nil) {
        
            if let lowestTemperature = lowestTemperature,
               let highestTemperature = highestTemperature {
                lowestHighestTemperatureLabel.setState(
                    "\(lowestTemperature.asInt)° / \(highestTemperature.asInt)°")
            }
            
            if let pressure = pressure {
                pressureLabel.setState( "\(pressure.rounded().asInt)hg" )
            }
            
            if let cloudiness = cloudiness {
                cloudinessLabel.setState( "\(cloudiness.rounded().asInt)%")
            }
            
            if let feelsLike = feelsLike {
                feelsLikeLabel.setState( "\(feelsLike.rounded().asInt)°" )
            }
        
            if let visibility = visibility {
                visibilityLabel.setState("\(visibility.rounded().asInt.formatted(.number.notation(.compactName)).lowercased())m")
            }
            
            if let windSpeed = windSpeed {
                windLabel.setState("\(windSpeed.rounded().asInt) m/s")
            }
        
            if let humidity = humidity {
                humidityLabel.setState("\(humidity.rounded().asInt)%")
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
            lowestHighestTemperatureLabel, pressureLabel])
        let column2 = UIStackView(arrangedSubviews: [
            cloudinessLabel, feelsLikeLabel, humidityLabel])
        let column3 = UIStackView(arrangedSubviews: [
            visibilityLabel,  windLabel])
        
        [column1, column2, column3].forEach { column in
            column.spacing = 40
            column.axis = .vertical

            weatherItemsStackview.addArrangedSubview(column)
        }
        
    }
    
    private func makeConstraints() {
        
        shadowView.pinToEdges()
        detailContainerView.pinToEdges()
        weatherItemsStackview.pinToEdges(withInset: .init(top: 24, left: 24, bottom: 24, right: 24))
        
    }
}

