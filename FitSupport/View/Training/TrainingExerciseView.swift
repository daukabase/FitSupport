//
//  TrainingExerciseView.swift
//  FitSupport
//
//  Created by Daulet on 25.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
class TrainingExerciseView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var session: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(_ exercise: Exercise){
        name.text = exercise.Name
        session.text = "\(exercise.TrainingSession?.reps ?? 0) раза \(exercise.TrainingSession?.times ?? 0) повт"
        image.image = exercise.Image ?? UIImage()
    }
}
