//
//  PreOrderViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 27/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct PreOrderViewModel {
    var numberOfPeople : Int?
    var bookingDate : String?
    var bookingTime : String?
    
    func getNumberOfTables() -> Int {
        return 10
    }
    
}
