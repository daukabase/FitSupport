//
//  ExerciseForWorkoutCell.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

protocol ExerciseForWorkoutCellDelegate: AnyObject {
    func add(_ exercise: Exercise)
    func remove(_ exercise: Exercise)
    func update(_ exercise: Exercise)
}

class ExerciseForWorkoutCell: ExerciseCell {
    
    weak var delegateExerciseBasket: ExerciseForWorkoutCellDelegate?
    private var currentExercise: Exercise?
    
    @IBOutlet weak var addButton: AddButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addButtonClicked(_ sender: AddButton) {
        if let exercise = currentExercise {
            sender.toogle()
            exercise.isSelected = sender.isClicked
            if sender.isClicked {
                delegateExerciseBasket?.add(exercise)
            } else {
                delegateExerciseBasket?.remove(exercise)
            }
            delegateExerciseBasket?.update(exercise)
        }
    }
    
    override func setIntoCell(_ exercise: Exercise) {
        self.currentExercise = exercise
        let isSelected = exercise.isSelected
        let currentTrainingSession = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        addButton.isSelected = isSelected
        self.addButton.isClicked = isSelected
        self.imageOfExercise.image = exercise.Image
        self.nameOfExercise.text = exercise.name
        self.exerciseSession.text = currentTrainingSession
    }
    
}
