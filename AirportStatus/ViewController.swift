//
//  ViewController.swift
//  AirportStatus
//
//  Created by John Cottrell on 8/18/17.
//  Copyright © 2017 John Cottrell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let urlString: String = "https://sservices.faa.gov/airport/status/HOU?format=application/json"
    var airportInfoArray = [[AirportInfo]]()
    var stateInfoArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // configure tableView
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        //loadJson()
        loadAirportsFile()
        
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
    
    func loadJson() {
        
        if let filepath = Bundle.main.path(forResource: "airports", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
            print("not found.")
        }
    }
    
    
    func loadAirportsFile() {
        
        let filename = "test"
        let type = "json"
        var data:Data
        var section = 0
        var airportInfoRow = [AirportInfo]()
        
        if let path = Bundle.main.path(forResource: filename, ofType: type) {
            do {
                let text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                //print(text)
                data = text.data(using: .utf8)!
                let json = try? JSONSerialization.jsonObject(with: data) as! [String:Any]
                if let json = json {
                    if let airports = json["airports"] {
                        print(airports)
                        for airport in airports as! [AnyObject] {
                            let airportCode = airport["airportCode"] as! String
                            let airportName = airport["airportName"] as! String
                            let cityName = airport["cityName"] as! String
                            let stateCode = airport["stateCode"] as! String
                            let stateName = airport["stateName"] as! String
                            let lat = airport["lat"] as! String
                            let lon = airport["lon"] as! String
                            let website = airport["website"] as! String
                            let airportInfo = AirportInfo(airportCode: airportCode, airportName: airportName, cityName: cityName, stateName: stateName, stateCode: stateCode, lat: lat, lon: lon, website: website)
                            airportInfoArray.append(airportInfo)
                            let stateInfo = stateName + " (" + stateCode + ")"
                            if stateInfoArray.contains(stateInfo) == false {
                                stateInfoArray.append(stateInfo)
                            }
                        }
                    }
                }
            
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
    }
    
    // TableView delegates
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.airportInfoArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.airportInfoArray[indexPath.row].airportName
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.stateInfoArray[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.stateInfoArray.count
    }
}
