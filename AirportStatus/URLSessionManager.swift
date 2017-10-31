//
//  URLSessionManager.swift
//  AirportStatus
//
//  Created by John Cottrell on 10/30/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import Foundation

protocol StatusDelegate {
    func statusDataLoaded(json: String)
}

class URLSessionManager {
    
    var airportCode: String
    var delegate: StatusDelegate?
    
    init(airportCode: String) {
        self.airportCode = airportCode
    }
    
    func getAirportWeather(url: String) -> String {
        
        var returnString: String = ""
        let faaUrlString = url.replacingOccurrences(of: "[AIRPORTCODE]", with: airportCode)
        print("faaUrlString = \(faaUrlString)")
        
        guard let url = URL(string: faaUrlString) else {
            print("Error: cannot create URL")
            return ""
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            if let error = error {
                print(error)
            } else {
                print("NO ERROR.")
            }
            
            if let response = response {
                print("response = \(response)")
            } else {
                print("NO RESPONSE.")
            }
            
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
//                print("dataString = \(dataString!)")
                returnString = dataString!
                self.delegate?.statusDataLoaded(json: dataString!)
                //return dataString!
            } else {
                print("NO DATA.")
            }
        })
        task.resume()
        return returnString
    }
}
