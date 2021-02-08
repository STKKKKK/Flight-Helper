//
//  Flight.swift
//  FlightHelper
//
//  Created by skk on 2021/2/6.
//  Copyright © 2021 deepBlue. All rights reserved.
//

import Foundation

struct Flight {

    var id: String
    var originID: Int
    var destinationID: Int
    var price: Int

    init(_ id: Int, _ originID: Int, _ destinationID: Int, _ price: Int) {
        self.id = "F\(id)"
        self.originID = originID
        self.destinationID = destinationID
        self.price = price
    }
}
