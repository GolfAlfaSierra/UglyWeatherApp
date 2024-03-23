//
//  Extensions.swift
//  VK Weather App Intern
//
//  Created by artyom s on 23.03.2024.
//

import UIKit

extension UILabel {
    func style(labelStyle: LabelStyle) -> UILabel {
        textColor = .white
        
        switch labelStyle {
        case .dateLabelStyle:
            font = .systemFont(ofSize: 12, weight: .light)
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
        }
        
        
        return self
    }
}

enum LabelStyle {
    case dateLabelStyle,
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
