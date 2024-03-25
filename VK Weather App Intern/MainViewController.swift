//
//  MainViewController.swift
//  VK Weather App Intern
//
//  Created by artyom s on 20.03.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func didRecieveTemperature(temperature: Int)
    func didRecieveTemperatureDescription(desc: String)
    func didRecieveWeather(weatherData: WeatherDetail)
    func didReciveDailyWeather(weathers: [WeatherDetailShort])
    func didRecieveLocation(lat:Double, lon: Double)
    func didRecieveCityName(name: String)
}

protocol MainViewPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class MainViewController: UIViewController {
    private let collectionview = MainView()
    var presenter: MainViewPresenterProtocol?
    private var state = MainViewState(weatherDetail: .init())
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCollecitonView()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func loadView() {
        view = collectionview
    }
    
    private func setupCollecitonView() {
        collectionview.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.resueId)
        collectionview.register(WeatherCollecitonViewCell.self,
                                forCellWithReuseIdentifier: WeatherCollecitonViewCell.reuseId)
        collectionview.dataSource = self
        collectionview.delegate = self
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, MainViewProtocol  {
    func didRecieveTemperatureDescription(desc: String) {
        state.weatherDescription = desc
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    func didRecieveTemperature(temperature: Int) {
        state.temperature = "\(temperature)"
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    func didReciveDailyWeather(weathers: [WeatherDetailShort]) {
        state.weatherDetailShort.append(contentsOf: weathers)
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
        
        
    }
    
    func didRecieveLocation(lat: Double, lon: Double) {
        state.lat = "\(lat)"
        state.lon = "\(lon)"

        collectionview.reloadData()
    }
    
    func didRecieveCityName(name: String) {
        state.cityName = name
        collectionview.reloadData()
    }
    
    func didRecieveWeather(weatherData: WeatherDetail) {
        state.weatherDetail = weatherData

        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        state.weatherDetailShort.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollecitonViewCell.reuseId, for: indexPath) as! WeatherCollecitonViewCell
        
        let item = state.weatherDetailShort[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: item.dayOfWeek)
        
        cell.setState(dayOfWeek: date, lowTemp: item.lowestTemperature, highTemp: item.highestTemperature, preceptiation: item.precipiation)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.resueId, for: indexPath) as! HeaderView
        
        let weatherDetail = WeatherDetail(
            lowestTemperature: state.weatherDetail.lowestTemperature,
            highestTemperature: state.weatherDetail.highestTemperature,
            feelsLike: state.weatherDetail.feelsLike,
            pressure: state.weatherDetail.pressure,
            cloudiness: state.weatherDetail.cloudiness,
            visibility: state.weatherDetail.visibility,
            humidity: state.weatherDetail.humidity,
            windSpeed: state.weatherDetail.windSpeed)
        
        headerView.setState(cityName: state.cityName,
                            temperature: state.temperature,
                            weatherDescription: state.weatherDescription,
                            lat: Double(state.lat), lon: Double(state.lon),
                            weatherDetail: weatherDetail)
        
        return headerView
    }
    
    
    
}


final class MainView: UICollectionView {
    private let layout = UICollectionViewFlowLayout()
    private let magicHeaderSize = CGSize(width: 300, height: 450)
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .background
        layout.scrollDirection = .vertical
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = .init(width: bounds.width * 8/9, height: 128)
        layout.headerReferenceSize = magicHeaderSize
    }
}

