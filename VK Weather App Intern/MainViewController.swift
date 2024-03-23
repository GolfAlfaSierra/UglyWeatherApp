//
//  MainViewController.swift
//  VK Weather App Intern
//
//  Created by artyom s on 20.03.2024.
//

import UIKit

struct MainViewModel {
    
    let currentDateTime: String
    let cityName: String
    let temperature: String
    let weatherDescription: String
    let lon: String
    let lat: String
    let weatherDetail: WeatherDetail
    var weatherDetailShort = [WeatherDetailShort]()
    
    struct WeatherDetail {
        let lowestTemperature: String
        let highestTemperature: String
        let feelsLike: String
        let sealevel: String
        let pressure: String
        let cloudiness: String
        let precipation: String
        let visibility: String
        let humidity: String
        let wind: String
    }
    
    struct WeatherDetailShort {
        let dayOfWeek:String
        let temperature:String
        let lowestTemperature:String
        let highestTemperature:String
        let precepiation: String
    }
    
    
}

final class MainViewController: UIViewController {
    
    let collectionview = MainView()
    
    
    override func loadView() {
        view = collectionview
        
    }
    
}

final class MainView: UICollectionView {
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .background
            
        register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.resueId)
    }
}



#Preview {
    
    return MainViewController()
}
#Preview {
    
    return HeaderView()
}
