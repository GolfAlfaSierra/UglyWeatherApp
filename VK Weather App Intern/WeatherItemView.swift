//
//  WeatherItem.swift
//  VK Weather App Intern
//
//  Created by artyom s on 23.03.2024.
//

import UIKit

final class WeatherItemView: UIStackView {
    
    private let titleLabel = UILabel().style(labelStyle: .weatherItemTitleLabelStyle)
    private let valueLabel = UILabel().style(labelStyle: .weatherItemValueLabelStyle)
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        configure()
        
        titleLabel.text = title
        valueLabel.text = value
    }
    
    func setState(_ value: String) {
        valueLabel.text = value
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
        
        axis = .vertical
        alignment = .center
        
        titleLabel.text = "N/A"
        valueLabel.text = "N/A"
        
        
    }
}
