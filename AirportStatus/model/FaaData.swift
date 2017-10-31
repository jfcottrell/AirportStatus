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

enum WeatherConditions: String {
    case Fair
    case PartlyCloudy
    case MostlyCloudy
    case AFewClouds
    case FogMist
    case Overcast
    case Rain
    case Breezy
}

struct Weather {
    var visibility: Float
    var weatherConditions: WeatherConditions
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
    var ICAO: String
    var city: String
    var status: Status
}
