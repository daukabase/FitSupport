//
//  Workout.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import RealmSwift

class Workout: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var currentDayCount = 0
    
    var days = List<Day>()
    var differentDays = List<Day>()
    
    private var workoutDaysForMonth: [Day] = []
    private var workoutDifferentDays: [Day] = []
    
    private var numberOfTrainingDays: Int = 12
    
    convenience init(id: String, name: String, daysForMonth: [Day], differentDays: [Day]) {
        self.init()
        self.id = id
        self.name = name
        self.workoutDaysForMonth = daysForMonth
        self.workoutDifferentDays = differentDays
        setDifferentDaysInWorkout(from: differentDays)
        setDatabaseDaysOfWorkout()
    }
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    var differentWorkoutDays: [Day] {
        return workoutDifferentDays
    }
    
    var WorkoutDaysForMonth: [Day] {
        return workoutDaysForMonth
    }
    var WorkoutDifferentDays: [Day] {
        return workoutDifferentDays
    }
    func getCurrenDay() -> Day {
        for day in workoutDaysForMonth {
            if !day.isCompleted(){
                return day
            }
        }
        return Day()
    }
    func completionRate() -> Int {
        if workoutDaysForMonth.count == 0 { return 0 }
        let competedDays = workoutDaysForMonth.filter({ $0.isCompleted() })
        return 100 * competedDays.count / workoutDaysForMonth.count
    }
    func update(_ day: Day) {
        for indexOfDay in 0 ..< workoutDaysForMonth.count {
            if day.dayCount == workoutDaysForMonth[indexOfDay].dayCount{
                try! uiRealm.write {
                    days[indexOfDay] = day
                    for indexOfExercise in 0..<day.ExercisesOfDay.count {
                        days[indexOfDay].dayExersises[indexOfExercise] = day.ExercisesOfDay[indexOfExercise]
                    }
                }
                workoutDaysForMonth[indexOfDay] = day
                return
            }
        }
    }
    func generateWorkoutMonthFrom(_ days: [Day]) {
        let totalNumberOfDifferentTrainingDays = days.count - 1
        var currentGeneratedDayCount = totalNumberOfDifferentTrainingDays
        var dayOfMonthCount = 0
        
        while(dayOfMonthCount < numberOfTrainingDays) {
            if totalNumberOfDifferentTrainingDays == -1 {
                break
            }
            let day = days[currentGeneratedDayCount]
            let currentDay = Day()
            for exercise in day.ExercisesOfDay{
                currentDay.add(new: exercise)
            }
            currentDay.dayCount = dayOfMonthCount + 1
            currentDay.dayName = day.dayName
            
            workoutDaysForMonth.append(currentDay)
            dayOfMonthCount += 1
            if currentGeneratedDayCount > 0 {
                currentGeneratedDayCount -= 1
            }else{
                currentGeneratedDayCount = totalNumberOfDifferentTrainingDays
            }
        }
        workoutDifferentDays = days
        setDatabaseDaysOfWorkout()
        setDifferentDaysInWorkout(from: days)
    }
}
extension Workout {
    
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
    func deleteFromRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
    func setDatabaseDaysOfWorkout() {
        for day in workoutDaysForMonth {
            days.append(day)
        }
    }
    func setDifferentDaysInWorkout(from days: [Day]) {
        for day in days {
            differentDays.append(day)
        }
    }
    
    func updateInRealm() {
        try! uiRealm.write {
            uiRealm.add(self, update: true)
        }
    }

    static func fetchAllWorkouts(onSuccess: @escaping([Workout]) -> ()) {
        let allWorkoutsInDatabase = uiRealm.objects(Workout.self)
        var workouts : [Workout] = []
        var days: [Day] = []
        var differentDays: [Day] = []
        for workout in allWorkoutsInDatabase {
            for day in workout.days {
//                try! uiRealm.write {
                    day.castExercises()
//                }
                days.append(day)
            }
            for day in workout.differentDays{
//                try! uiRealm.write {
                    day.castExercises()
//                }
                differentDays.append(day)
            }
            
            workouts.append(Workout(id: workout.id,
                                    name: workout.name,
                                    daysForMonth: days,
                                    differentDays: differentDays))
            days = []
            differentDays = []
        }
        onSuccess(workouts)
    }
    
    static func fetchCurrentWorkout(of user: User) -> Workout? {
        let workoutID = user.currentWorkoutID
        if let currentWorkout = uiRealm.objects(Workout.self).filter({ $0.id == workoutID }).first {
            var days: [Day] = []
            var differentDays: [Day] = []
            for day in currentWorkout.days {
                day.castExercises()
                days.append(day)
            }
            for day in currentWorkout.differentDays{
//                try! uiRealm.write {
                    day.castExercises()
//                }
                differentDays.append(day)
            }
            return Workout(id: currentWorkout.id,
                           name: currentWorkout.name,
                           daysForMonth: days,
                           differentDays: differentDays)
        }
        return nil
    }
}
