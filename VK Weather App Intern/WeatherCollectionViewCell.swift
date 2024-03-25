//
//  WeatherCollectionViewCell.swift
//  VK Weather App Intern
//
//  Created by artyom s on 24.03.2024.
//

import UIKit

final class WeatherCollecitonViewCell: UICollectionViewCell {
    static let reuseId = String(describing: WeatherCollecitonViewCell.self)
    
    private let shadowView = ShadowView()
    private let containerView = UIView()
    
    let dayOfWeekLabel = UILabel().style(labelStyle: .dayOfweekLabelStyle)
    
    private let stackview = UIStackView()
    let lowestHigheestLabel = WeatherItemView(title: "Low / High", value: "N/A")
    let precipiationLabel = WeatherItemView(title: "Precipiation", value: "N/A")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }
    
    
    
    private func configure() {
        dayOfWeekLabel.text = "N/A"
        
        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)
        containerView.backgroundColor = .white
        
        let radius: CGFloat  = 10
        containerView.layer.cornerRadius = radius
        contentView.layer.cornerRadius = radius
        shadowView.layer.cornerRadius = radius
        
        
        [dayOfWeekLabel, stackview].forEach({contentView.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false})
        [
         lowestHigheestLabel,
         precipiationLabel
        ].forEach({
            stackview.addArrangedSubview($0)
            
            $0.spacing = 4 })
        
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.spacing = 8
    }
    
    private func makeConstraints() {
        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dayOfWeekLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            stackview.leadingAnchor.constraint(equalTo: dayOfWeekLabel.trailingAnchor, constant: padding),
            stackview.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    
    func setState(dayOfWeek: Date? = nil, lowTemp: String? = nil, highTemp: String? = nil, preceptiation: String? = nil) {
        let df = DateFormatter()
        df.dateFormat = "E"
        
        if let dayOfWeek = dayOfWeek {
            dayOfWeekLabel.text = df.string(from: dayOfWeek)
        }
        if let lowTemp = lowTemp, let highTemp = highTemp {
            lowestHigheestLabel.setState("\(lowTemp)º / \(highTemp)º")
        }
        
        if let preceptiation = preceptiation {
            precipiationLabel.setState("\(preceptiation) mm")
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.frame = contentView.bounds
        containerView.frame = contentView.bounds
    }
}

