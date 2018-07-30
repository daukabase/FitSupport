//
//  Exercises.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
class Exercises {
    
    static func getAll() -> [Exercise] {
        return self.allExercises
    }
    static func filtered(by muscleType: MuscleType) -> [Exercise] {
        return allExercises.filter({ ($0.MuscleType?.contains(muscleType)) ?? false })
    }
    static private var allExercises: [Exercise] = [
        Exercise(name: "Жим штанги лежа", description: "", image: UIImage(named: "jim_wtangi"), muscleType: [.arm, .chest], trainingSession: TrainingSession(reps: 5, times: 6))
    ]
    
//        self.allExercises.append()
//        self.allExercises.append(Exercise(name: "Французкий жим вверх лежа", description: "", image: #imageLiteral(resourceName: "francuzkjiy_jim_verha"), muscleType: [.arm], trainingSession: TrainingSession(reps: 5, times: 6)))
//        self.allExercises.append(Exercise(name: "Выпады со штангой", description: "", image: #imageLiteral(resourceName: "vipady_so_wtangoy"), muscleType: [.leg], trainingSession: TrainingSession(reps: 5, times: 6)))
//        self.allExercises.append(Exercise(name: "Жим гантелей на наклоненной вниз скамье", description: "", image: #imageLiteral(resourceName: "jim_ganteley_na_naklonnoy_skamiye"), muscleType: [.chest, .arm], trainingSession: TrainingSession(reps: 5, times: 6)))
//        self.allExercises.append(Exercise(name: "Армейский жим сидя", description: "", image: #imageLiteral(resourceName: "army_jim_sidya"), muscleType: [.shoulders, .arm], trainingSession: TrainingSession(reps: 5, times: 6)))
//        self.allExercises.append(Exercise(name: "Вертикальная тяга", description: "", image: #imageLiteral(resourceName: "vertikalnaya_tyaga"), muscleType: [.back], trainingSession: TrainingSession(reps: 5, times: 6)))
    
    
}
