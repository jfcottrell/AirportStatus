//
//  ViewController.swift
//  AirportStatus
//
//  Created by John Cottrell on 8/18/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let urlString: String = "https://services.faa.gov/airport/status/HOU?format=application/json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
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
                print(response)
            } else {
                print("NO RESPONSE.")
            }
            
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            } else {
                print("NO DATA.")
            }
            
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
