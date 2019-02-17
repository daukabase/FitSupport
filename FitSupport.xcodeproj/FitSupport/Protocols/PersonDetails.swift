//
//  PersonDetails.swift
//  FitSupport
//
//  Created by Daulet on 28.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

protocol HasMultipleWeights {
    var UpdatedWeights: [Double] {get}
    func updateCurrent(_ weight: Double)
}

protocol HasExercises {
    var ExercisesOfDay: [Exercise] {get}
    func add(new exercise: Exercise)
}

protocol Selectable {
    var isSelected: Bool {get set}
}

protocol CheckIfDataisFilled {
    func allDataIsFilled() -> Bool
}

