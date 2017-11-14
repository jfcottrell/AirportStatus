//
//  FaaDataParser.swift
//  AirportStatus
//
//  Created by John Cottrell on 10/31/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import Foundation

struct FaaDataParser {
    
    func parseJsonString(json: String) -> FaaData? {
        
        var faaData: FaaData
        
        let data: Data = json.data(using: .utf8)!
        
        // guard against invalid json
//        if JSONSerialization.isValidJSONObject(data) {
//            print("Valid Json")
//        } else {
//            print("InValid Json")
//            return
//        }
        
        let json = try? JSONSerialization.jsonObject(with: data) as! [String:Any]
        
        // check to see if there has been a json exception
        if let exception = json!["Exception"] {
            print("Exception: \(exception)")
            return nil
        }
        
        // top level json data
        guard let delayString = json!["delay"] else {
            print ("can't parse delay")
            return nil
        }
        
        guard let iata = json!["IATA"] else {
            print ("can't parse IATA")
            return nil
        }
        
        guard let state = json!["state"] else {
            print ("can't parse state")
            return nil
        }
        
        guard let name = json!["name"] else {
            print ("can't parse name")
            return nil
        }
        
        guard let city = json!["city"] else {
            print ("can't parse city")
            return nil
        }
        
        // weather conditions sub-data
        let weather = json!["weather"] as! [String:Any]
        
        guard let conditions = weather["weather"] else {
            print("can't parse weather: conditions")
            return nil
        }
        
        guard let visibility = weather["visibility"] else {
            print("can't parse weather: visibility")
            return nil
        }
        
        guard let wind = weather["wind"] else {
            print("can't parse weather: wind")
            return nil
        }
        
        guard let temp = weather["temp"] else {
            print("can't parse weather: temp")
            return nil
        }

        let vis = visibility as! Float
        let conditionsString = (conditions as! String)
        let windArray = (wind as! String).components(separatedBy: " ")
        var windDirectionString: String?
        var windDirection: WindDirection
        var windSpeed: String?
        windDirectionString = windArray[0]
        windDirection = WindDirection(rawValue: windDirectionString!)!
        windSpeed = windArray[2]
        
        // there can be *multiple* weather conditions so store them in array
        var conditionsArray: [String] = []
        
        if conditionsString.range(of:"Fair") != nil {
            conditionsArray.append("fair")
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
            conditionsArray.append("rain")
        }
        
        if conditionsString.range(of:"Breezy") != nil {
            conditionsArray.append("breezy")
        }
        
        if conditionsString.range(of:"Light Drizzle") != nil {
            conditionsArray.append("lightdrizzle")
        }
        
        let weatherInfo = Weather(visibility: vis, weatherConditions: conditionsArray, tempF: temp as! String, windDirection: windDirection, windSpeed: windSpeed!)
        
        // status sub-data
        let status = json!["status"] as! [String:Any]
        
        guard let avgDelay = status["avgDelay"] else {
            print("can't parse status: avg delay")
            return nil
        }
        
        guard let reason = status["reason"] else {
            print("can't parse status: reason")
            return nil
        }
        
        guard let minDelay = status["minDelay"] else {
            print("can't parse status: minDelay")
            return nil
        }
        
        guard let maxDelay = status["maxDelay"] else {
            print("can't parse status: maxDelay")
            return nil
        }
        
        guard let trend = status["trend"] else {
            print("can't parse status: trend")
            return nil
        }
        
        guard let endTime = status["endTime"] else {
            print("can't parse status: endTime")
            return nil
        }
        
        guard let closureEnd = status["closureEnd"] else {
            print("can't parse status: closureEnd")
            return nil
        }
        
        guard let type = status["type"] else {
            print("can't parse status: type")
            return nil
        }
        
        guard let closureBegin = status["closureBegin"] else {
            print("can't parse status: closureBegin")
            return nil
        }
        
        let statusInfo = Status(reason: reason as! String, closureBegin: closureBegin as! String, endTime: endTime as! String, minDelay: minDelay as! String, avgDelay: avgDelay as! String, maxDelay: maxDelay as! String, closureEnd: closureEnd as! String, trend: trend as! String, type: type as! String)

        var delay: Bool = false
        if (delayString as! String).lowercased() == "true" {
            delay = true
        }
        
        faaData = FaaData(delay: delay, IATA: iata as! String, state: state as! String, name: name as! String, weather: weatherInfo, /*ICAO: icao as! String,*/ city: city as! String, status: statusInfo)
        faaData.printData()
        return faaData
    }
}

func printFaaData(faaData: FaaData) {
    print("------ FAA Data ------")
    print("delay:  \(faaData.delay)")
    print("IATA:   \(faaData.IATA)")
    print("state:  \(faaData.state)")
    print("city:   \(faaData.city)")
    print("name:   \(faaData.name)")
    print("weather")
    print("  visibility:  \(faaData.weather.visibility)")
    print("  conditions:  \(faaData.weather.weatherConditions)")
    print("  temperature: \(faaData.weather.tempF)")
    print("  wind dir:    \(faaData.weather.windDirection.rawValue)")
    print("  wind speed:  \(faaData.weather.windSpeed)")
    print("status")
    print("  reason:        \(faaData.status.reason)")
    print("  closure begin: \(faaData.status.closureBegin)")
    print("  closure end:   \(faaData.status.closureEnd)")
    print("  end time:      \(faaData.status.endTime)")
    print("  min delay:     \(faaData.status.minDelay)")
    print("  avg delay:     \(faaData.status.avgDelay)")
    print("  max delay:     \(faaData.status.maxDelay)")
    print("  trend:         \(faaData.status.trend)")
    print("  type:          \(faaData.status.type)")
}
