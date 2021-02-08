//
//  ViewController.swift
//  FlightHelper
//
//  Created by skk on 2021/1/31.
//  Copyright © 2021 deepBlue. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(1, forKey: "directFlightMode")
    }
    
    func saveInput() {
        let origin = originTextField.text ?? ""
        let destination = destinationTextField.text ?? ""
        defaults.set(origin, forKey: "origin")
        defaults.set(destination, forKey: "destination")
    }
    
    @IBAction func searchFlights(_ sender: Any) {
        saveInput()
    }
    
    @IBAction func searchCheapestPath(_ sender: Any) {
        saveInput()
    }
    
}
