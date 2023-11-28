//
//  WeatherViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 22/11/23.
//

import UIKit
import SnapKit


class WeatherViewController: UIViewController {

    var weatherViewModel = WeatherViewModel()
    let weatherView = WeatherView(frame: UIScreen.main.bounds)
    
    var weather: WeatherData

    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchWeatherData()
        setupTargets()
    }
    
    func setupTargets() {
        weatherView.searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
    }

    // MARK: - Setup UI
    func setupUI() {
        view.addSubview(weatherView)
        // Weather view constraints
        weatherView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        // Set up collection view delegates and data source
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.delegate = self
    }

    // Fetch weather data
    func fetchWeatherData() {
        weatherViewModel.delegate = self
        weatherViewModel.fetchWeatherData()
    }
    
}


extension WeatherViewController: WeatherViewDelegate {
    
    // MARK: - Add button target
    @objc func didTapSearch() {
        let vc = SearchViewController()
        present(vc, animated: true, completion: nil)
    }
    
}


// MARK: - WeatherViewModelDelegate
extension WeatherViewController: WeatherViewModelDelegate {
    
    func updateUI(with data: WeatherData) {
        
        DispatchQueue.main.async {
            
            self.weatherView.temperatureLabel.text = "\(Int(round(weatherModel.list[1].main.temp)))°C"

//            self.weatherView.humidityData.text = "\(weatherModel.list[1].main.humidity)%"
//
//            self.weatherView.airPressureData.text = "\(weatherModel.list[1].main.pressure) mb"
//
//            self.weatherView.windStatusData.text = "\(Int(round(weatherModel.list[1].wind.speed))) mph"
//
//            self.weatherView.visibilityData.text = "\(String(format: "%.1f",(Double(weatherModel.list[1].visibility) / 1609.0))) miles"
//
//            self.weatherView.weatherImage.image = UIImage(named: weatherModel.list[1].weather[0].icon)
//
//            self.weatherView.cityName.text = weatherModel.city.name
//
//            self.weatherView.dateText.text = self.viewModel.convertDateString(weatherModel.list[1].dt_txt)
//
//            self.viewModel.getHighestTemp(model: weatherModel)

            self.weatherView.collectionView.reloadData()

        }
    }
}
    

// MARK: - Collection view delegates
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherViewModel.dailyWeather.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCell", for: indexPath) as! DailyCell
        let dailyWeather = weatherViewModel.dailyWeather[indexPath.item]
        cell.configure(with: dailyWeather)
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

