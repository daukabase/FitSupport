//
//  ExerciseCell.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell, Customizable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageOfExercise: UIImageView!
    @IBOutlet weak var nameOfExercise: UILabel!
    @IBOutlet weak var exerciseSession: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonInit() {
        imageOfExercise.layer.cornerRadius = containerView.frame.height / 2
        imageOfExercise.layer.masksToBounds = true
        
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.dropShadow(color: .black, alpha: 0.15, x: 0, y: 2, blur: 10, spread: -4)
    }
    
    func setIntoCell(_ exercise: Exercise) {
        self.imageOfExercise.image = exercise.Image
        self.nameOfExercise.text = exercise.name
        let currentTrainingSession = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        self.exerciseSession.text = currentTrainingSession
    }
}
