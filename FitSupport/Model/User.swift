//
//  User.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit


let allWeightsKilosAvailable = Array(20...200)
let alLWeightsGrammsAvailable = (0...20).map({$0 * 50})
let allHeihgtsAvailable = Array(80...250)

struct User: Describable, HasMultipleWeights {
    
    private var name: String?
    private var avatar: UIImage?
    private var height: Double?
    private var description: String?
    private var workoutsOfUser: [Workout]?
    private var birthday: Date?
    var currentWeight: Double?
    
    private var allUpdatedWeights: [Double] = []{
        didSet{
            print(allUpdatedWeights)
            currentWeight = allUpdatedWeights.last
        }
    }
    
    init(name: String, avatar: UIImage?, weight: Double, height:Double, birthday: Date) {
        self.name = name
        self.avatar = avatar
        self.height = height
        self.birthday = birthday
        updateCurrent(weight)
    }
    
    
    mutating func updateCurrent(_ weight: Double) {
        print(weight)
        allUpdatedWeights.append(weight)
    }
    
    mutating func add(workout: Workout) {
        self.workoutsOfUser?.append(workout)
    }
    var UpdatedWeights: [Double]{
        return allUpdatedWeights
    }
    var Age: Int?{
        if let birthday = birthday{
            return TimeInterval.countOfYears(from: birthday)
        }
        return nil
    }
    var Height: Double?{
        get{
            return height
        }
        set{
            self.height = newValue
        }
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

extension TimeInterval{
    static func countOfYears(from birthDate: Date) -> Int {
        return Int(Double(Date.init().timeIntervalSince(birthDate)/(3600*12*365*2)))
    }
}
