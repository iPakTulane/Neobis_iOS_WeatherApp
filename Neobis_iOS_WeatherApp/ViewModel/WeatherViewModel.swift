//
//  WeatherViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 23/11/23.
//


import Foundation

class WeatherViewModel {
    
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
    }
    

    func fetchWeatherData(completion: @escaping (Result<WeatherData, APIError>) -> Void) {
        
        // Replace your actual API key
        let apiKey = "edb8b212378fdca33a7ce86abac712d4"
        let apiUrlString = "https://api.openweathermap.org/data/2.8/onecall?lat=41.311081&lon=69.240562&exclude=hourly,minutely&limit=6&appid=\(apiKey)"

        guard let apiUrl = URL(string: apiUrlString) else {
            completion(.failure(.invalidURL))
            return
        }

        NetworkingService.shared.fetchData(from: apiUrl) { [weak self] (result: Result<WeatherData, APIError>) in
            switch result {
            case .success(let weatherData):
                // Update weather properties
                self?.updateWeatherData(weatherData: weatherData)
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
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


