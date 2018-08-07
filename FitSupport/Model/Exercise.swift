//
//  Exercise.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
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
enum GlobalColors{
    case darkBlue, lightyBlue, whity, lightyGray, disablebColor
    func color() -> UIColor {
        switch self {
        case .darkBlue:
            return UIColor(displayP3Red: 35/255, green: 57/255, blue: 91/255, alpha: 1)
        case .lightyBlue:
            return UIColor(displayP3Red: 61/255, green: 153/255, blue: 1, alpha: 1)
        case .whity:
            return UIColor(displayP3Red: 251/255, green: 251/255, blue: 252/255, alpha: 1)
        case .lightyGray:
            return UIColor(displayP3Red: 234/255, green: 237/255, blue: 235/255, alpha: 1)
        case .disablebColor:
            return UIColor(displayP3Red: 175/255, green: 174/255, blue: 174/255, alpha: 1)
//            UIColor(displayP3Red: 107/255, green: 107/255, blue: 107/255, alpha: 1)
        }
    }
}
enum ExerciseState{
    case willdo, doing, done
    func image() -> UIImage {
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
struct Exercise: Describable, Selectable {
    
    var isSelected: Bool = false
    var exerciseNumberInDay: Int?
    var exerciseState: ExerciseState = .willdo
    private var name: String?
    private var description: String?
    private var duration: Int?
    private var image: UIImage?
    private var muscleType: [MuscleType]?
    
    private var trainingSession: TrainingSession?
    
    init(name: String?, description: String?, image: UIImage?, muscleType: [MuscleType]?, trainingSession: TrainingSession?) {
        self.name = name
        self.description = description
        self.image = image
        self.muscleType = muscleType
        self.trainingSession = trainingSession
    }
    
    var Name: String?{
        get{
            return name
        }
        set{
            name = newValue
        }
    }

    var TrainingSession: TrainingSession?{
        get{
            return trainingSession
        }
        set{
            trainingSession = newValue
        }
    }

    var MuscleType: [MuscleType]?{
        get{
            return muscleType
        }
        set{
            muscleType = newValue
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
    
    var Duration: Int?{
        get{
            return duration
        }
        set{
            duration = newValue
        }
    }
    
    var Image: UIImage?{
        get{
            return image
        }
        set{
            image = newValue
        }
    }
    
    
}

