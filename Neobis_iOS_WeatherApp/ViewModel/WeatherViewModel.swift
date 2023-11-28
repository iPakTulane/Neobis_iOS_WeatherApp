//
//  WeatherViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 23/11/23.
//


import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func updateUI(with data: WeatherData)
    var data: [WeatherData] { get }
}

class WeatherViewModel {

    weak var delegate: WeatherViewModelDelegate?

    var weatherData: WeatherData?

    var currentLocation: String = "Tashkent, Uzbekistan" // Default location

    // Current weather properties
    var currentTemperature: String = ""
    var weatherIcon: String = ""
    var windSpeed: String = ""
    var humidity: String = ""
    var visibility: String = ""
    var airPressure: String = ""

    // Daily weather properties
    var dailyWeather: [DailyWeatherViewModel] = []

    func updateLocation(city: String, country: String) {
        // Format the location string as "City, Country"
        currentLocation = "\(city), \(country)"
        delegate?.updateWeather() // Notify delegate about the update
    }

    func getCurrentDate() -> String {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"

        return dateFormatter.string(from: currentDate)
    }

    func updateWeatherData(weatherData: WeatherData) {
        // Update current weather properties
        let currentWeather = weatherData.current
        currentTemperature = "\(currentWeather.temp) °C"
        if let weather = currentWeather.weather.first {
            weatherIcon = weather.icon
        }
        windSpeed = "\(currentWeather.windSpeed) m/s"
        humidity = "\(currentWeather.humidity)%"
        visibility = "\(currentWeather.visibility) meters"
        airPressure = "\(currentWeather.pressure) hPa"

        // Update daily weather properties
        let dailyData = weatherData.daily
        dailyWeather = dailyData.prefix(5).map { DailyWeatherViewModel(dailyData: $0) }

        delegate?.updateWeather()
    }

    var data = [WeatherData]()
    
    func fetchWeatherData(by cityName: String) {
        // Replace your actual API key
        let apiKey = "edb8b212378fdca33a7ce86abac712d4"
        let apiUrlString =  "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(apiKey)"
        guard let apiUrl = URL(string: apiUrlString) else {
            return
        }
        
        NetworkingService.shared.fetchData(from: apiUrl) { [weak self] (result: Result<[WeatherData], APIError>) in
            switch result {
            case .success(let weatherData):
                // Update weather properties
                self.data = weatherData
                self?.updateWeatherData(weatherData: weatherData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct DailyWeatherViewModel {
    var weekday: String
    var weatherIcon: String
    var temperature: String

    init(dailyData: Daily) {
        // Initialize stored properties first
        self.weekday = ""
        self.weatherIcon = ""
        self.temperature = ""

        // Now call methods or use 'self' after initializing stored properties
        self.weekday = getWeekday(from: dailyData.dt)
        self.weatherIcon = dailyData.weather.first?.icon ?? ""
        self.temperature = "\(Int(dailyData.temp.day)) °C"
    }

    private func getWeekday(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // Full weekday name
        return dateFormatter.string(from: date)
    }
}
