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

//enum WeatherConditions: String {
//    case Fair =  "Fair"
//    case PartlyCloudy = "Partly Cloudy"
//    case MostlyCloudy = "Mostly Cloudy"
//    case AFewClouds = "A Few Clouds"
//    case FogMist = "Fog/Mist"
//    case Overcast = "Overcast"
//    case Rain = "Rain"
//    case Breezy = "Breezy"
//    case LightDrizzle = "Light Drizzle"
//}

struct Weather {
    var visibility: Float
    //var weatherConditions: WeatherConditions      // turns out airports can have multiple weather conditions so a single enum won't work
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
    var ICAO: String
    var city: String
    var status: Status
}
