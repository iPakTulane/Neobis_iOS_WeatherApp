//
//  WeatherView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 23/11/23.
//

import Foundation
import UIKit
import SnapKit


// MARK: - WeatherViewDelegate
protocol WeatherViewDelegate: AnyObject {
    func didTapSearch()
}

class WeatherView: UIView {
    
//    weak var delegate: WeatherViewDelegate?
    
    // MARK: - UI components
    var searchButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(named: "search"), for: .normal)
//        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor.black
//        button.tintColor = .black
//        button.backgroundColor = .red
        return button
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Today, May 7th, 2023"
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Barcelona"
        return label
    }()
    
    var countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Spain"
        return label
    }()
    
    var circleView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    var iconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "snowfall")
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "10°C"
        return label
    }()
    
    var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Wind status"
        return label
    }()
    
    var windInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "7 mph"
        return label
    }()
    
    var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Humidity"
        return label
    }()
    
    var humidityInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "85%"
        return label
    }()
    
    var visibilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Visibility"
        return label
    }()
    
    var visibilityInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "6.4 miles"
        return label
    }()
    
    var airLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Air pressure"
        return label
    }()
    
    var airInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "998 mb"
        return label
    }()
    
    var containerView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 40.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        return gradient
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
//        setupGradient()
        self.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup UI
    func setupHierarchy() {
        addSubview(searchButton)
        addSubview(dateLabel)
        addSubview(cityLabel)
        addSubview(countryLabel)
        addSubview(circleView)
        circleView.addSubview(iconView)
        circleView.addSubview(temperatureLabel)
        addSubview(windLabel)
        addSubview(windInfoLabel)
        addSubview(humidityLabel)
        addSubview(humidityInfoLabel)
        addSubview(visibilityLabel)
        addSubview(visibilityInfoLabel)
        addSubview(airLabel)
        addSubview(airInfoLabel)
        addSubview(containerView)
        containerView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        // searchButton
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.right.equalToSuperview().inset(50)
            make.width.height.equalTo(80)
        }
        
        // dateLabel
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(85)
            make.width.equalTo(140)
            make.height.equalTo(17)
        }
        
        // cityLabel
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom)
            make.width.equalTo(212)
            make.height.equalTo(50)
        }
        
        // countryLabel
        countryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        
        // circleView
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(countryLabel.snp.bottom).offset(35)
            make.width.height.equalTo(240)
        }
        
        // iconView
        iconView.snp.makeConstraints { make in
            make.centerX.equalTo(circleView.snp.centerX)
            make.top.equalTo(circleView.snp.top).offset(12)
            make.width.height.equalTo(75)
        }
        
        // temperatureLabel
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(circleView.snp.centerX)
            make.centerY.equalTo(circleView.snp.centerY)
        }
        
        // windLabel
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(57)
            make.width.equalTo(90)
            make.height.equalTo(17)
        }
        
        // windInfoLabel
        windInfoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(windLabel.snp.centerX)
            make.top.equalTo(windLabel.snp.bottom).offset(8)
            make.width.equalTo(65)
            make.height.equalTo(25)
        }
        
        // humidityLabel
        humidityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(windLabel.snp.centerX)
            make.top.equalTo(windInfoLabel.snp.bottom).offset(20)
            make.width.equalTo(90)
            make.height.equalTo(17)
        }
        
        // humidityInfoLabel
        humidityInfoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(humidityLabel.snp.centerX)
            make.top.equalTo(humidityLabel.snp.bottom).offset(8)
            make.width.equalTo(65)
            make.height.equalTo(25)
        }
        
        // visibilityLabel
        visibilityLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(30)
            make.trailing.equalToSuperview().offset(-57)
            make.width.equalTo(90)
            make.height.equalTo(17)
        }
        
        // visibilityInfoLabel
        visibilityInfoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(visibilityLabel.snp.centerX)
            make.top.equalTo(visibilityLabel.snp.bottom).offset(8)
            make.width.equalTo(65)
            make.height.equalTo(25)
        }
        
        // airLabel
        airLabel.snp.makeConstraints { make in
            make.centerX.equalTo(visibilityLabel.snp.centerX)
            make.top.equalTo(visibilityInfoLabel.snp.bottom).offset(20)
            make.width.equalTo(90)
            make.height.equalTo(17)
        }
        
        // airInfoLabel
        airInfoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(airLabel.snp.centerX)
            make.top.equalTo(airLabel.snp.bottom).offset(8)
            make.width.equalTo(65)
            make.height.equalTo(25)
        }
        
        // containerView
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        // collectionView
        collectionView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
        }
    }
    
    func setupGradient() {
        gradientLayer.frame = bounds
        let startColor = UIColor(red: 0.189, green: 0.637, blue: 0.771, alpha: 1)
        let endColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = bounds.insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        gradientLayer.position = center
        layer.insertSublayer(gradientLayer, at: 0)
//        self.layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Add button target
//    func didTapSearch() {
//        self.delegate?.didTapSearch()
//    }
    
}
