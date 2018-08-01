//
//  Day.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation

struct Day: HasExercises {
    var dayCount: Int?
    var allExercises: [Exercise] = []
    var workoutIsCompleted = false
    mutating func intoExercisesAdd(new exercise: Exercise) {
        self.allExercises.append(exercise)
    }
}
