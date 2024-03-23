//
//  ShadowView.swift
//  VK Weather App Intern
//
//  Created by artyom s on 23.03.2024.
//

import UIKit

final class ShadowView: UIView {
    private let shadow1 = CALayer()
    private let shadow2 = CALayer()

    
    init() {
        super.init(frame: .zero)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.addSublayer(shadow1)
        layer.addSublayer(shadow2)
        
        backgroundColor = UIColor.clear
        

        shadow1.shadowRadius = 2
        shadow2.shadowRadius = 24
        
        shadow1.shadowOpacity = 0.08
        shadow2.shadowOpacity = 0.08
        
        shadow1.shadowOffset = .init(width: 0, height: 2)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadow1.frame = bounds
        shadow2.frame = bounds
        
        shadow1.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shadow2.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
