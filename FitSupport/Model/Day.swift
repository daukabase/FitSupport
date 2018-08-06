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
    var workoutIsCompleted : Bool {
        get{
            return isCompleted()
        }
    }
    init() {}
    init(name: String, count: Int, exercises: [Exercise]) {
        self.dayName = name
        self.dayCount = count
        for execise in exercises {
            add(new: execise)
        }
    }
    mutating func add(new exercise: Exercise) {
        var exerciseToAppend = exercise
        exerciseToAppend.exerciseNumberInDay = allExercises.count
        self.exercisesOfDay.append(exerciseToAppend)
    }
    mutating func update(exercise: Exercise){
        for exerciseIndex in 0...(exercisesOfDay.count ) {
            if exercisesOfDay[exerciseIndex].exerciseNumberInDay == exercise.exerciseNumberInDay{
                exercisesOfDay[exerciseIndex] = exercise
                print("Exercise in DAY updated successfully!!!")
            }
        }
        print("Exercise UPDATE ERROR fatal!!!")
    }
    
    var currentExercise: Exercise?{
        didSet{
            if let currentExercise = currentExercise{
                inDayUpdate(exercise: currentExercise)
            }
        }
    }
    var exercisesStack = Stack<Exercise>(size: 20)
    
    mutating func beginThisDayTraining(){
        for index in (0...(exercisesOfDay.count-1)).reversed() {
            print(exercisesStack.push(item: exercisesOfDay[index]))
        }
        nextExercise()
    }
    mutating func nextExercise(){
        guard var currentExercise = currentExercise else {
            resetCurrentExerciseInTraining()
            return
        }
        currentExercise.exerciseState = .done
        inDayUpdate(exercise: currentExercise)
        resetCurrentExerciseInTraining()
    }
    private mutating func inDayUpdate(exercise: Exercise){
        for indexOfExercise in 0..<exercisesOfDay.count {
            if exercisesOfDay[indexOfExercise].exerciseNumberInDay == exercise.exerciseNumberInDay {
                exercisesOfDay[indexOfExercise] = exercise
                break
            }
        }
    }
    var allExercisesCompleted = false
    mutating private func resetCurrentExerciseInTraining(){
        currentExercise = exercisesStack.pop()
        allExercisesCompleted = true
        currentExercise?.exerciseState = .doing
    }
    
    
    func doneExercises() -> [Exercise] {
        var doneDays :[Exercise] = []
        for exercise in exercisesOfDay {
            doneDays.append(exercise)
        }
        return doneDays
    }
    
    func isCompleted() -> Bool {
        for exercise in exercisesOfDay{
            if exercise.exerciseState != .done{
                return false
            }
        }
        return true
    }
    
}
