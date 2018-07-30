//
//  ExerciseCell.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {
    
    @IBOutlet weak var imageOfExercise: UIImageView!
    @IBOutlet weak var nameOfExercise: UILabel!
    @IBOutlet weak var exerciseSession: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageOfExercise.layer.cornerRadius = imageOfExercise.frame.height / 2
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIntoCell(_ exercise: Exercise){
        self.imageOfExercise.image = exercise.Image
        self.nameOfExercise.text = exercise.Name
        let currentTrainingSession = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        self.exerciseSession.text = currentTrainingSession
    }
}
