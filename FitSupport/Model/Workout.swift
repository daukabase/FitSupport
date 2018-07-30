//
//  Workout.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
struct Workout {
    var name: String?
    var currentDayNumber: Int?
    var workoutDays: [Day]?
    func completionRate() -> Int {
        guard let days = workoutDays else {
            return 0
        }
        let doneDays = days.filter({$0.workoutIsCompleted})
        return doneDays.count/days.count
    }
}
