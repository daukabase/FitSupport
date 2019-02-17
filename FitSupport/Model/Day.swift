//
//  Day.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Day: Object, HasExercises {
    
    
    @objc dynamic var dayCount = 0
    @objc dynamic var dayName = ""
    
    var dayExersises = List<Exercise>()
    
    var exercisesOfDay: [Exercise] = []
    
    var ExercisesOfDay: [Exercise] {
        return exercisesOfDay
    }
    
    var currentExercise: Exercise?

    func fill(name: String, count: Int, exercises: [Exercise]) {
        self.dayName = name
        self.dayCount = count
        for execise in exercises {
            add(new: execise)
        }
    }
    func add(new exercise: Exercise) {
        if exercise.Id != nil {
            let exerciseToAppend = Exercise(id: exercise.exerciseID, name: exercise.Name!, image: exercise.Image, muscleType: exercise.MuscleType!, trainingSession: exercise.TrainingSession!)
            exerciseToAppend.exerciseNumberInDay = ExercisesOfDay.count
            self.exercisesOfDay.append(exerciseToAppend)
            
            dayExersises.append(exerciseToAppend)
        }
    }
    func castExercises(){
        for exercise in dayExersises {
            if let castedExercise = Exercise.castExerciseFrom(exercise: exercise){
                exercisesOfDay.append(castedExercise)
            }
        }
    }
    
     func update(exercise: Exercise){
        for exerciseIndex in 0..<(exercisesOfDay.count - 1) {
            if exercisesOfDay[exerciseIndex].exerciseNumberInDay == exercise.exerciseNumberInDay{
                let exerciseToUpdate = Exercise(id: exercise.exerciseID, name: exercise.Name!, image: exercise.Image, muscleType: exercise.MuscleType!, trainingSession: exercise.TrainingSession!)
                exercisesOfDay[exerciseIndex] = exerciseToUpdate
                dayExersises[exerciseIndex] = exerciseToUpdate
                print("Exercise in DAY updated successfully!!!")
            }
            
        }
    }
        var exercisesStack = Stack<Exercise>(size: 20)
    
     func beginThisDayTraining(){
        for index in (0...(exercisesOfDay.count-1)).reversed() {
            if !exercisesOfDay[index].isDone{
                print(exercisesStack.push(item: exercisesOfDay[index]))
            }
        }
        nextExercise()
    }
     func nextExercise(){
        guard let currentExercise = currentExercise else {
            resetCurrentExerciseInTraining()
            return
        }
        currentExercise.exerciseState = .done
        currentExercise.isDone = true
        inDayUpdate(exercise: currentExercise)
        resetCurrentExerciseInTraining()
    }
    
    private  func inDayUpdate(exercise: Exercise){
        for indexOfExercise in 0..<exercisesOfDay.count {
            if exercisesOfDay[indexOfExercise].exerciseNumberInDay == exercise.exerciseNumberInDay {
                exercisesOfDay[indexOfExercise] = exercise
                break
            }
        }
    }
    
    
     private func resetCurrentExerciseInTraining(){
        currentExercise = exercisesStack.pop()
        currentExercise?.exerciseState = .doing
        print("ASD")
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
extension Day{
}


