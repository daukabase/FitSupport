//
//  User.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

let allWeightsKilosAvailable = Array(20...200)
let alLWeightsGrammsAvailable = (0...20).map({$0 * 50})
let allHeihgtsAvailable = Array(80...250)

var currentUser: User?

class User: Object, HasMultipleWeights {
    
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var birthday = Date()
    @objc dynamic var height = 0
    @objc dynamic var currentWorkoutID: String?
    
    let workouts = List<Workout>()
    let allUpdatedWeights = List<Double>()
    
    var currentWeight: Double? {
        return allUpdatedWeights.last
    }

    var weights: [Double] {
        return Array(allUpdatedWeights)
    }
    
    var age: Int? {
        return Date.getYears(since: birthday)
    }
    
    func updateCurrent(_ weight: Double) {
        do {
            try realm?.write {
                allUpdatedWeights.append(weight)
            }
        }
        catch {
            allUpdatedWeights.append(weight)
        }
    }
    
    convenience init(name: String, avatarName: String?, weight: Double, height:Int, birthday: Date) {
        self.init()
        self.name = name
        self.height = height
        self.birthday = birthday
        updateCurrent(weight)
    }
    
    override class func primaryKey() -> String {
        return "email"
    }
    
    func setCurrent(workout: Workout) {
        try! uiRealm.write {
            currentWorkoutID = workout.id
        }
    }
}

extension User {
    
    static func ifUserExist(onSuccess: @escaping(User?) -> ()) {
        let userFromRealm = uiRealm.objects(User.self)
        if userFromRealm.count > 0 {
            onSuccess(userFromRealm.first)
        }
        else{
            onSuccess(nil)
        }
    }
    
    static func getIndexOf(kilos weight: Double) -> Int{
        for index in 0..<allWeightsKilosAvailable.count{
            if allWeightsKilosAvailable[index] == Int(weight){
                return index
            }
        }
        return 0
    }
    
    static func getIndexOf(gramms weight: Double) -> Int{
        let gramms = Int((weight - Double(Int(weight))) * 1000)
        for index in 0..<alLWeightsGrammsAvailable.count{
            if alLWeightsGrammsAvailable[index] == gramms{
                return index
            }
        }
        return 0
    }
    
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
    
    func updateIntoRealm() {
        try! uiRealm.write {
            uiRealm.add(self, update: true)
        }
    }

    func deleteFromRealm() {
        let userFromRealm = uiRealm.objects(User.self)
        try! uiRealm.write {
            uiRealm.delete(userFromRealm)
        }
    }
    
    
}
