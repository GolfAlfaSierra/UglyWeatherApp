//
//  SceneDelegate.swift
//  VK Weather App Intern
//
//  Created by artyom s on 20.03.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureRootViewController(with: windowScene)
    }
    
    private func configureRootViewController(with windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeMainViewController()
        window?.makeKeyAndVisible()
    }
    
    func makeMainViewController() -> MainViewController {
        let mainView = MainViewController()
        let weatherSerivce = OpenWaetherService()
        let locationService = LocationService()
        let dailyWeatherService = OpenMeteoWeatherService()
        let presenter = MainViewPresenter(view: mainView,
                                          weatherService: weatherSerivce,
                                          locationService: locationService,
                                          dailyWeatherService: dailyWeatherService)
        mainView.presenter = presenter
        
        return mainView
    }
}

