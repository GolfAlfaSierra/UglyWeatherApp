//
//  Extensions.swift
//  VK Weather App Intern
//
//  Created by artyom s on 23.03.2024.
//

import UIKit
import CoreLocation

extension UILabel {
    func style(labelStyle: LabelStyle) -> UILabel {
        textColor = .white
        
        switch labelStyle {
        case .cityNameLabelStyle:
            font = .systemFont(ofSize: 48, weight: .bold)
        case .temperatureLabelStyle:
            font = .systemFont(ofSize: 40, weight: .medium)
        case .weatherDescriptionLabelStyle:
            font = .systemFont(ofSize: 16, weight: .regular)
        case .coordinateLabelStyle:
            font = .systemFont(ofSize: 14, weight: .light)
        case .weatherItemTitleLabelStyle:
            font = .systemFont(ofSize: 14, weight: .semibold)
            textColor = .label
        case .weatherItemValueLabelStyle:
            font = .systemFont(ofSize: 14, weight: .medium)
            textColor = .secondaryLabel
        case .dayOfweekLabelStyle:
            font = .systemFont(ofSize: 24, weight: .medium)
            textColor = .label
        }
        
        
        return self
    }
}

enum LabelStyle {
    case
    cityNameLabelStyle,
    temperatureLabelStyle,
    weatherDescriptionLabelStyle,
    coordinateLabelStyle,
    weatherItemTitleLabelStyle,
    weatherItemValueLabelStyle,
    dayOfweekLabelStyle
}

extension UIView {
    func pinToEdges(withInset inset: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            fatalError("Cannot pin to edges without a superview.")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset.right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: inset.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset.bottom)
        ])
    }
}


extension Double {
    var asInt: Int {
        Int(self)
    }
}


extension String {
    var asInt: Int? {
        
        return Int(self)
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
