//
//  TrainingExerciseCell.swift
//  FitSupport
//
//  Created by Daulet on 02.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

enum PositionOfLine {
    case top, bottom
}

class TrainingExerciseCell: ExerciseCell {

    @IBOutlet var exerciseProgress: ExerciseStateImage!
    
    lazy var linePath: UIBezierPath = {
        let linePath = UIBezierPath()
        var startYposition = indexInTable == 0 ? center.y : -frame.height
        var endYposition = isLastExercise ? frame.height / 2 : frame.height
        linePath.move(to: CGPoint(x: exerciseProgress.center.x, y: startYposition))
        linePath.addLine(to: CGPoint(x: exerciseProgress.center.x, y: endYposition))
        linePath.lineWidth = 1.5
        linePath.close()
        return linePath
    }()
    
    private var exercise: Exercise? {
        didSet {
            
        }
    }
    private var indexInTable: Int?
    private var isLastExercise = false
    private var dayIsCompleted = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        if !dayIsCompleted {
            switch exercise?.exerciseState {
            case .done?:
                UIColor.lightyBlue.set()
            default:
                UIColor.lightyGray.set()
            }
            linePath.stroke()
        }
    }
    
    func set(_ exercise: Exercise, position index: Int, isLast: Bool = false, dayIsCompleted: Bool) {
        self.dayIsCompleted = dayIsCompleted
        self.exerciseProgress.isHidden = dayIsCompleted
        self.isLastExercise = isLast
        self.indexInTable = index
        self.exercise = exercise
        self.exercise?.exerciseNumberInDay = index
        nameOfExercise.text = exercise.name
        imageOfExercise.image = exercise.muscleType![0].image()
        
        exerciseProgress.set(exercise.exerciseState, count: exercise.exerciseNumberInDay ?? 0)
        setNeedsDisplay()
    }
}
