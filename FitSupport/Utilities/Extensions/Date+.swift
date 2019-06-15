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
    
    static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: self)
    }
    
}
