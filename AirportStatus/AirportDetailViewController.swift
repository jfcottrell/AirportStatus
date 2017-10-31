//
//  AirportDetailViewController.swift
//  AirportStatus
//
//  Created by John Cottrell on 10/26/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import Foundation
import UIKit

class AirportDetailViewController: UIViewController, StatusDelegate {
    
    var airportDataModel: AirportDataModel?
    var index: Int?
    @IBOutlet weak var airportNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let airportName = airportDataModel?.airportInfo[index!].airportName
        let airportCode = airportDataModel?.airportInfo[index!].airportCode
        airportNameLabel.text = airportName
        
        let sessionManager = URLSessionManager(airportCode: airportCode!)
        sessionManager.delegate = self
        _ = sessionManager.getAirportWeather(url: "https://services.faa.gov/airport/status/[AIRPORTCODE]?format=application/json")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Status delegate callback
    func statusDataLoaded(json: String) {
        
        print("json = \(json)")
    }

}
