//
//  ViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 29/11/23.
//

import Foundation
import UIKit

protocol WeatherViewModelType {
    
    var didTapSearch: (() -> Void)? { get set }
    
    var updateSearch: ((Weather) -> Void)? { get set }
    var updateForecast: ((Forecast) -> Void)? { get set }
    
    func fetchWeatherData(cityName: String)
    func fetchWeekWeatherData(cityName: String)
}

class WeatherViewModel: WeatherViewModelType {
    
    private var weatherService: WeatherService!
    private(set) var weatherData : Weather? {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }
    
    private(set) var forecastData: Forecast? {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }
    
    var bindWeatherViewModelToController : (() -> Void) = {}
    
    var updateSearch: ((Weather) -> Void)?
    var updateForecast: ((Forecast) -> Void)?
    
    lazy var didTapSearch: (() -> Void)? = { [weak self] in
        self?.updateSearch?(self?.weatherData ?? Weather(name: "", sys: CityInfo(type: 0, id: 0, country: "", sunrise: 0, sunset: 0), weather: [], main: MainInfo(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 0, humidity: 0), visibility: 0, wind: WindInfo(speed: 0.0, deg: 0)))
        self?.updateForecast?(self?.forecastData ?? Forecast(list: []))
    }
    
    init() {
        self.weatherService = WeatherService()
        fetchWeatherData(cityName: "London")
        fetchWeekWeatherData(cityName: "London")
    }
    
    func fetchWeatherData(cityName: String) {
        weatherService.fetchWeather(cityName: cityName) { (weatherData) in
            self.weatherData = weatherData
        }
    }
    
    func fetchWeekWeatherData(cityName: String) {
        weatherService.fetchWeekWeather(cityName: cityName) { (forecastData) in
            self.forecastData = forecastData
        }
    }
}
