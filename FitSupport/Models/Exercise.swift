//
//  Exercise.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

class Exercise: Object, Selectable {
    
    @objc dynamic var id = ""
    @objc dynamic var exerciseID = ""
    @objc dynamic var isDone = false{
        didSet {
            if isDone {
                exerciseState = .done
            }
        }
    }
    @objc dynamic var name: String?
    
    
    var duration: Int?
    var isSelected: Bool = false
    var exerciseNumberInDay: Int?
    var exerciseState: ExerciseState = .willdo
    
    fileprivate var image: UIImage?
    private var trainingSession: TrainingSession?
    
    convenience init(id: String, name: String?, image: UIImage?, muscleType: [MuscleType]?, trainingSession: TrainingSession?) {
        self.init()
        self.id = UUID().uuidString
        self.exerciseID = id
        self.name = name
        self.image = image
        self.muscleType = muscleType
        self.trainingSession = trainingSession
    }
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    
    var Id: String? {
        return exerciseID
    }
    
    var TrainingSession: TrainingSession?{
        get{
            return trainingSession
        }
        set{
            trainingSession = newValue
        }
    }

    var muscleType: [MuscleType]?
    
    var Image: UIImage?{
        get{
            return image
        }
        set{
            image = newValue
        }
    }    
}

extension Exercise {
    static func castExerciseFrom(exercise: Exercise) -> Exercise? {
        let execiseToCast = Exercises.getExercise(by: exercise.exerciseID)
        if let execiseToCast = execiseToCast {
            let castedExercises = Exercise(id: execiseToCast.exerciseID,
                                           name: execiseToCast.name ,
                                           image: execiseToCast.image,
                                           muscleType: execiseToCast.muscleType,
                                           trainingSession: execiseToCast.trainingSession)
            castedExercises.isDone = exercise.isDone
            return castedExercises
        }
        return nil
    }
}

struct TrainingSession {
    
    var times: Int?
    var reps: Int?
    
    init(reps: Int, times: Int) {
        self.reps = reps
        self.times = times
    }
    
}

enum MuscleType: String {
    
    case arm = "Мышцы Рук"
    case back = "Спина"
    case shoulders = "Плечи"
    case leg = "Мышцы Ног"
    case abs = "Пресс"
    case chest = "Грудь"
    
    func image() -> UIImage{
        switch self {
        case .arm:
            return #imageLiteral(resourceName: "arm_200px")
        case .back:
            return #imageLiteral(resourceName: "back_200px")
        case .shoulders:
            return #imageLiteral(resourceName: "shoulders_200px")
        case .leg:
            return #imageLiteral(resourceName: "leg_200px")
        case .abs:
            return #imageLiteral(resourceName: "abs_200px")
        case .chest:
            return #imageLiteral(resourceName: "chest_200px")
        }
    }
}


enum ExerciseState {
    
    case willdo, doing, done
    
    func getImage() -> UIImage {
        switch self {
        case .willdo:
            return #imageLiteral(resourceName: "exerciseToDoIcon")
        case .doing:
            return #imageLiteral(resourceName: "exerciseDoing")
        case .done:
            return #imageLiteral(resourceName: "doneExercise")
        }
    }
}
