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
    
    private var currentExercise: Exercise?
    private var indexInTable: Int?
    private var isLastExercise = false
    private var dayIsCompleted = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        if !dayIsCompleted{
            var startYposition = -self.frame.height
            var endYposition = self.frame.height
            switch indexInTable {
            case 0:
                startYposition = center.y
            default:
                break
            }
            if isLastExercise{
                endYposition = self.frame.height/2
            }
            let line = UIBezierPath()
            line.move(to: CGPoint(x: exerciseProgress.center.x, y: startYposition))
            line.addLine(to: CGPoint(x: exerciseProgress.center.x, y: endYposition))
            line.lineWidth = 1.5
            line.close()
            switch currentExercise?.exerciseState {
            case .done?:
                GlobalColors.lightyBlue.color().set()
            default:
                GlobalColors.lightyGray.color().set()
            }
            line.stroke()
        }
    }
    func set(_ exercise: Exercise, position index: Int, isLast: Bool = false, dayIsCompleted: Bool) {
        self.dayIsCompleted = dayIsCompleted
        self.exerciseProgress.isHidden = dayIsCompleted
        self.isLastExercise = isLast
        self.indexInTable = index
        currentExercise = exercise
        nameOfExercise.text = exercise.Name
        imageOfExercise.image = exercise.MuscleType![0].image()
        exercise.exerciseNumberInDay = index
        exerciseProgress.set(exercise.exerciseState, count: exercise.exerciseNumberInDay ?? 0)
        setNeedsDisplay()
    }
}
