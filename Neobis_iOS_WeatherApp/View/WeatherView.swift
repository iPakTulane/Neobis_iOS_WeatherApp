//
//  WeatherView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 23/11/23.
//

import UIKit
import SnapKit

class WeatherView: UIView {
    
    // MARK: - View model
    private var viewModel: WeatherViewModel
    
    // MARK: - Data
    let dailyModel: [WeatherData] = [
        WeatherData(day: "Sunday", image: "snow", temperature: "10°C"),
        WeatherData(day: "Monday", image: "sunAndRain", temperature: "8°C"),
        WeatherData(day: "Tuesday", image: "hail", temperature: "3°C"),
        WeatherData(day: "Thursday", image: "thunder", temperature: "5°C"),
        WeatherData(day: "Friday", image: "clouds", temperature: "9°C"),
    ]
    
    // MARK: - UI components
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Today, May 7th, 2023"
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Barcelona"
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Spain"
        return label
    }()
    
    private lazy var circleView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "snowfall")
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "10°C"
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Wind status"
        return label
    }()
    
    private lazy var windInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "7 mph"
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Humidity"
        return label
    }()
    
    private lazy var humidityInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "85%"
        return label
    }()
    
    private lazy var visibilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Visibility"
        return label
    }()
    
    private lazy var visibilityInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "6.4 miles"
        return label
    }()
    
    private lazy var airLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Air pressure"
        return label
    }()
    
    private lazy var airInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "998 mb"
        return label
    }()
    
    private lazy var containerView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 40.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        return gradient
    }()
    
    // MARK: - Initialization
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
        setupGradient()
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.width.height.equalTo(30)
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        // collectionView
        collectionView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
//            make.width.equalTo(70)
//            make.height.equalTo(90)
        }
    }
    
    // MARK: - Add action
    @objc private func didTapSearch() {
        viewModel.didTapSearch()
    }
    
}

// MARK: - Extension
extension WeatherView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCell", for: indexPath) as! DailyCell
        let data = dailyModel[indexPath.item]
        cell.configureCell(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Vertical spacing between rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Horizontal spacing between rows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 15) // Adjust the height as needed
        }

        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) 

                let label = UILabel()
                label.text = "The next 5 days"
                label.font = UIFont.boldSystemFont(ofSize: 10)
                label.textAlignment = .left
                label.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 12)
                headerView.addSubview(label)

                return headerView
            }
            return UICollectionReusableView()
        }
    
}
