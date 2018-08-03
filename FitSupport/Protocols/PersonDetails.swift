//
//  PersonDetails.swift
//  FitSupport
//
//  Created by Daulet on 28.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

protocol Describable {
    var Name: String? {get set}
    var Description:String? {get set}
    var Image: UIImage? {get set}
}

protocol HasMultipleWeights {
    var currentWeight: Int? {get set}
    var UpdatedWeights: [Int]? {get}
    mutating func updateCurrent(weight: Int)
}

protocol HasExercises {
    var allExercises: [Exercise] {get}
    mutating func add(new exercise: Exercise)
}

protocol Selectable {
    var isSelected: Bool {get set}
}
