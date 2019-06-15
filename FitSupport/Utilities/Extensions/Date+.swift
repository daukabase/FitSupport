//
//  TimeInterval.swift
//  FitSupport
//
//  Created by Daulet on 17/02/2019.
//  Copyright © 2019 Daulet. All rights reserved.
//

import Foundation

extension Date {
    
    static func getYears(since date: Date) -> Int {
        let now = Date()
        let years = Int(now.timeIntervalSince(date) / (3600 * 24 * 365))
        return years
    }
    
}
