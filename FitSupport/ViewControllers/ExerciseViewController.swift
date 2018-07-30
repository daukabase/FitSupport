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
    
    func set(_ exercise: Exercise) {
        print("sdf")
        imageOfExercise.image = exercise.Image ?? UIImage()
        print(exercise.Name)
        nameOfExercise.text = exercise.Name
        let currentTrainingSession = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        trainingSession.text = currentTrainingSession
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfExercise.text = "SAY MA NAME    "
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
