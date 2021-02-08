//
//  ViewController.swift
//  FlightHelper
//
//  Created by skk on 2021/1/31.
//  Copyright © 2021 deepBlue. All rights reserved.
//

import UIKit
import Foundation

class FlightViewController: UIViewController {

    @IBOutlet weak var flightTableView: UITableView!
        
    var flights = [Flight]()
    let cities = DefaultData.cities
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let dbManager = DBManager.shareInstance()
        
        let origin = defaults.string(forKey: "origin") ?? ""
        let destination = defaults.string(forKey: "destination") ?? ""
        
        if dbManager.openDB() {
            print("Open Database Success")
        }
        
        if origin == "" {
            if let destinationID = getId(destination) {
                flights = dbManager.retrieve(destinationID, by: "destinationID")
            }
        } else if destination == "" {
            if let originID = getId(origin) {
                flights = dbManager.retrieve(originID, by: "originID")
            }
        } else {
            if let destinationID = getId(destination), let originID = getId(origin) {
                flights = dbManager.retrieve2(originID, destinationID)
            }
        }
    }
    
    
    func getId(_ val: String) -> Int? {
        for index in 0..<cities.count {
            if val == cities[index] {
                return index
            }
        }
        return nil
    }
}



extension FlightViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath)

        let index = indexPath.row
        let flight = flights[index]

        cell.textLabel?.text = "\(flight.id),  \(cities[flight.originID])->\(cities[flight.destinationID])"
        cell.detailTextLabel?.text = "$ \(flight.price)"
        return cell
    }
}
