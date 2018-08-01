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

struct Exercise: Describable, Selectable {
    
    var isSelected: Bool = false
    
    private var name: String?
    private var description: String?
    private var duration: Int?
    private var image: UIImage?
    private var muscleType: [MuscleType]?
    var isDone = false
    
    private var trainingSession: TrainingSession?
    
    init(name: String?, description: String?, image: UIImage?, muscleType: [MuscleType]?, trainingSession: TrainingSession?) {
        self.name = name
        self.description = description
//        self.duration = duration
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

