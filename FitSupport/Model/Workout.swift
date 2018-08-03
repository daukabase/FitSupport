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
    private var workoutDaysForMonth: [Day] = []
    private var numberOfTrainingDays: Int = 12
    
    init(name: String, and days: [Day]) {
        self.name = name
        self.differentWorkoutDays = days
        generateWorkoutMonthFrom(days)
    }
    
    var differentWorkoutDays: [Day] = []
    var WorkoutDaysForMonth : [Day] {
        return workoutDaysForMonth
    }
    
    mutating func add(new exercise: Exercise){
        workoutDaysForMonth[0].add(new: exercise)
    }
    func currentDay() -> Day {
        for day in workoutDaysForMonth {
            if !day.workoutIsCompleted{
                return day
            }
        }
        return Day()
    }
    mutating func onlyForTest(){
        workoutDaysForMonth[0].workoutIsCompleted = true
    }
    func completionRate() -> Int {
        let doneDays = workoutDaysForMonth.filter({$0.workoutIsCompleted})
        return doneDays.count/workoutDaysForMonth.count
    }
    
    private mutating func generateWorkoutMonthFrom(_ days: [Day]) {
        let totalNumberOfDifferentTrainingDays = days.count - 1
        var currentGeneratedDayCount = totalNumberOfDifferentTrainingDays
        var dayOfMonthCount = 0
        
        while(dayOfMonthCount < numberOfTrainingDays){
            if totalNumberOfDifferentTrainingDays == -1 {
                break
            }
            var currentDay = days[currentGeneratedDayCount]
            currentDay.dayCount = dayOfMonthCount + 1
//            print("DAY NAME \(currentDay.dayName!)  DAYS COUNT \(currentDay.allExercises.count)")
            workoutDaysForMonth.append(currentDay)
            dayOfMonthCount += 1
            if currentGeneratedDayCount > 0 {
                currentGeneratedDayCount -= 1
            }else{
                currentGeneratedDayCount = totalNumberOfDifferentTrainingDays
            }
        }
    }
}
