//
//  Day.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation

struct Day: HasExercises {
    
    private var exercisesOfDay: [Exercise] = []
    var dayCount: Int?
    var dayName: String?
    var allExercises: [Exercise] {
        return exercisesOfDay
    }
    var workoutIsCompleted = false
    
    init(name: String, count: Int, exercises: [Exercise]) {
        self.dayName = name
        self.dayCount = count
        for execise in exercises {
            add(new: execise)
        }
    }
    init() {
        print("EMPTY DAY initialized")
    }
    
    mutating func add(new exercise: Exercise) {
        var exerciseToAppend = exercise
        exerciseToAppend.exerciseNumberInDay = allExercises.count
        self.exercisesOfDay.append(exerciseToAppend)
    }
}
