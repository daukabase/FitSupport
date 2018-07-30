//
//  User.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
struct User: Describable, HasMultipleWeights {
    
    private var name: String?
    private var description: String?
    private var avatar: UIImage?
    private var workoutsOfUser: [Workout]?
    var currentWeight: Int?
    
    private var allUpdatedWeights: [Int]?
    
    var UpdatedWeights: [Int]?{
        return allUpdatedWeights
    }
    
    mutating func updateCurrent(weight: Int) {
        allUpdatedWeights?.append(weight)
    }
    
    mutating func intoWorkoutsAdd(new workout: Workout) {
        self.workoutsOfUser?.append(workout)
    }
    
    var WorkoutsOfUser: [Workout]? {
        return workoutsOfUser
    }
    
    var Name: String?{
        get{
            return name
        }
        set{
            name = newValue
        }
    }
    
    var Description: String?{
        get{
            return description
        }
        set{
            description = newValue
        }
    }
    
    var Image: UIImage?{
        get{
            return avatar
        }
        set{
            avatar = newValue
        }
    }
}
