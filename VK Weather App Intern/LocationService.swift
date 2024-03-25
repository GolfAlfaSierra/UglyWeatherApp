//
//  LocationService.swift
//  VK Weather App Intern
//
//  Created by artyom s on 25.03.2024.
//

import CoreLocation
 
final class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    var didReciveCordinates: ((Double,Double) -> ())? = nil
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        
        requestLocationTracking()
    }

    func requestLocationTracking() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            print("failed to get permission")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            print("failed to check auth status")
        }
    }

    // MARK: - CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        manager.stopUpdatingLocation()
        didReciveCordinates?(lat, lon)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {}
}


