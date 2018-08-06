//
//  ExerciseViewController.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var currentExercise: Exercise?
    
    @IBOutlet weak var imageOfExercise: UIImageView!
    @IBOutlet weak var nameOfExercise: UILabel!
    @IBOutlet weak var trainingSession: UILabel!
    
    private func set(_ exercise: Exercise) {
        imageOfExercise.image = exercise.Image ?? UIImage()
        nameOfExercise.text = exercise.Name
        let currentTrainingSession = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        trainingSession.text = currentTrainingSession
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentExercise = currentExercise{
            set(currentExercise)
        }
    }
}
