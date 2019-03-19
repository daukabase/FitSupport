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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLayer() {
        imageOfExercise.layer.shadowPath = UIBezierPath(roundedRect: imageOfExercise.frame, cornerRadius: imageOfExercise.frame.height / 2).cgPath
        
        imageOfExercise.layer.cornerRadius = containerView.frame.height / 2
        imageOfExercise.layer.masksToBounds = true
        imageOfExercise.clipsToBounds = true
        
        containerView.backgroundColor = .clear
        containerView.dropShadow(color: .black, alpha: 0.15, x: 0, y: 2, blur: 15, spread: -4)
        let dx: CGFloat = 2
        let rect = containerView.bounds.insetBy(dx: dx, dy: dx)
        containerView.layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: containerView.bounds.height / 2).cgPath
    }
    
    func setIntoCell(_ exercise: Exercise) {
        self.imageOfExercise.image = exercise.Image
        self.nameOfExercise.text = exercise.name
        let currentTrainingSession = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        self.exerciseSession.text = currentTrainingSession
    }
}
