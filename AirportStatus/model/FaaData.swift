//
//  FaaData.swift
//  AirportStatus
//
//  Created by John Cottrell on 10/31/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import Foundation

enum WindDirection: String {
    case North
    case Northwest
    case Northeast
    case South
    case Southeast
    case Southwest
    case East
    case West
    case Variable
}

struct Weather {
    var visibility: Float
    var weatherConditions: [String]
    var tempF: String
    var windDirection: WindDirection
    var windSpeed: String
}

struct Status {
    var reason: String
    var closureBegin: String
    var endTime: String
    var minDelay: String
    var avgDelay: String
    var maxDelay: String
    var closureEnd: String
    var trend: String
    var type: String
}

struct FaaData {
    var delay: Bool
    var IATA: String
    var state: String
    var name: String
    var weather: Weather
    var city: String
    var status: Status
    
    func printData() {
        print("------ FAA Data ------")
        print("delay:  \(delay)")
        print("IATA:   \(IATA)")
        print("state:  \(state)")
        print("city:   \(city)")
        print("name:   \(name)")
        print("weather")
        print("  visibility:  \(weather.visibility)")
        print("  conditions:  \(weather.weatherConditions)")
        print("  temperature: \(weather.tempF)")
        print("  wind dir:    \(weather.windDirection.rawValue)")
        print("  wind speed:  \(weather.windSpeed)")
        print("status")
        print("  reason:        \(status.reason)")
        print("  closure begin: \(status.closureBegin)")
        print("  closure end:   \(status.closureEnd)")
        print("  end time:      \(status.endTime)")
        print("  min delay:     \(status.minDelay)")
        print("  avg delay:     \(status.avgDelay)")
        print("  max delay:     \(status.maxDelay)")
        print("  trend:         \(status.trend)")
        print("  type:          \(status.type)")
    }
}
