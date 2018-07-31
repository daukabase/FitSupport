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
}
class ExerciseForWorkoutCell: ExerciseCell {
    
    weak var delegateExerciseBasket: ExerciseForWorkoutCellDelegate?
    var currentExercise: Exercise?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addButtonClicked(_ sender: AddButton) {
        if let exercise = currentExercise{
            sender.swapImage()
            if sender.isClicked{
                delegateExerciseBasket?.add(exercise)
            }else{
                delegateExerciseBasket?.remove(exercise)
            }
        }
    }
    
    override func setIntoCell(_ exercise: Exercise){
        currentExercise = exercise
        self.imageOfExercise.image = #imageLiteral(resourceName: "jim_ganteley_na_naklonnoy_skamiye")// exercise.Image
        self.nameOfExercise.text = exercise.Name
        let currentTrainingSession = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        self.exerciseSession.text = currentTrainingSession
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
