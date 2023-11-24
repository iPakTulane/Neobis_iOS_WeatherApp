//
//  CurrentModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 23/11/23.
//

import Foundation

struct CurrentModel: Codable {
    let image: String
    let temperature: String
    let wind: String
    let humidity: String
    let visibility: String
    let airPressure: String
}
