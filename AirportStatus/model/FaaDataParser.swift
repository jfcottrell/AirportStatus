//
//  FaaDataParser.swift
//  AirportStatus
//
//  Created by John Cottrell on 10/31/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import Foundation

struct FaaDataParser {
    
    func parseJsonString(json: String) {
        
        var data: Data = json.data(using: .utf8)!
        var faaData: FaaData
        
        let json = try? JSONSerialization.jsonObject(with: data) as! [String:Any]
        let weather = json!["weather"] as! [String:Any]
        print("weather = \(weather)")
        
        guard let conditions = weather["weather"] else {
            print("can't parse weather conditions")
            return
        }
        
        guard let visibility = weather["visibility"] else {
            print("can't parse weather visibility")
            return
        }
        
        guard let wind = weather["wind"] else {
            print("can't parse weather wind")
            return
        }
        
        guard let temp = weather["temp"] else {
            print("can't parse weather temp")
            return
        }

        let vis = visibility as! Float
        let conditionsString = (conditions as! String) //.removingWhitespaces()
//        let cond = WeatherConditions(rawValue: conditionsString)
        let windArray = (wind as! String).components(separatedBy: " ")
        var windDirectionString: String?
        var windDirection: WindDirection
        var windSpeed: String?
        windDirectionString = windArray[0]
        windDirection = WindDirection(rawValue: windDirectionString!)!
        windSpeed = windArray[2]

        print("vis = \(vis)")
//        print("cond = \(String(describing: cond))")
        print("wind dir = \(String(describing: windDirection))")
        print("wind speed = \(String(describing: windSpeed))")
        print("temp = \(temp)")
        
        var conditionsArray: [String] = []
        
        if conditionsString.range(of:"Fair") != nil {
            conditionsArray.append("Fair")
        }
        
        if conditionsString.range(of:"Partly Cloudy") != nil {
            conditionsArray.append("partlycloudy")
        }
        
        if conditionsString.range(of:"Mostly Cloudy") != nil {
            conditionsArray.append("mostlycloudy")
        }
        
        if conditionsString.range(of:"A Few Clouds") != nil {
            conditionsArray.append("afewclouds")
        }
        
        if conditionsString.range(of:"Fog/Mist") != nil {
            conditionsArray.append("fogmist")
        }
        
        if conditionsString.range(of:"Overcast") != nil {
            conditionsArray.append("overcast")
        }
        
        if conditionsString.range(of:"Rain") != nil {
            conditionsArray.append("Rain")
        }
        
        if conditionsString.range(of:"Breezy") != nil {
            conditionsArray.append("breezy")
        }
        
        if conditionsString.range(of:"Light Drizzle") != nil {
            conditionsArray.append("lightdrizzle")
        }
        
        print("conditions array = \(conditionsArray)")
    
        let weatherInfo = Weather(visibility: vis, weatherConditions: conditionsArray, tempF: temp as! String, windDirection: windDirection, windSpeed: windSpeed!)
        
        let status = json!["status"] as! [String:Any]
        print("status = \(status)")
        
        guard let avgDelay = status["avgDelay"] else {
            print("can't parse status avg delay")
            return
        }
        
        guard let reason = status["reason"] else {
            print("can't parse status reason")
            return
        }
        
        guard let minDelay = status["minDelay"] else {
            print("can't parse status minDelay")
            return
        }
        
        guard let maxDelay = status["maxDelay"] else {
            print("can't parse status maxDelay")
            return
        }
        
        guard let trend = status["trend"] else {
            print("can't parse status trend")
            return
        }
        
        guard let endTime = status["endTime"] else {
            print("can't parse status endTime")
            return
        }
        
        guard let closureEnd = status["closureEnd"] else {
            print("can't parse status closureEnd")
            return
        }
        
        guard let type = status["type"] else {
            print("can't parse status type")
            return
        }
        
        guard let closureBegin = status["closureBegin"] else {
            print("can't parse status closureBegin")
            return
        }
        
        print("avg delay = \(avgDelay)")
        print("reason = \(reason)")
        print("minDelay = \(minDelay)")
        print("maxDelay = \(maxDelay)")
        print("trend = \(trend)")
        print("endTime = \(endTime)")
        print("closureEnd = \(closureEnd)")
        print("type = \(type)")
        print("closureBegin = \(closureBegin)")
        
        
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
