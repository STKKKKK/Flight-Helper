//
//  ViewController.swift
//  FlightHelper
//
//  Created by skk on 2021/1/31.
//  Copyright © 2021 deepBlue. All rights reserved.
//

import UIKit

class CheapestPathViewController: UIViewController {

    @IBOutlet weak var pathLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let cities = DefaultData.cities
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        let origin = defaults.string(forKey: "origin") ?? ""
        let destination = defaults.string(forKey: "destination") ?? ""
        
        if let destinationID = getId(destination), let originID = getId(origin) {
            let spp = Spp(source: originID, destination: destinationID)
            pathLabel.text = spp.shortway()
            totalPriceLabel.text = "Total Price:  $ \(spp.dj())"
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
