//
//  AirportDetailViewController.swift
//  AirportStatus
//
//  Created by John Cottrell on 10/26/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import Foundation
import UIKit

class AirportDetailViewController: UIViewController {
    
    var airportDataModel: AirportDataModel?
    var index: Int?
    @IBOutlet weak var airportNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let airportName = airportDataModel?.airportInfo[index!].airportName
        airportNameLabel.text = airportName
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
