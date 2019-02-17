//
//  ExerciseOfDayCell.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ExerciseOfDayCell: UITableViewCell {
    
    private var exerciseOfCell: Exercise?
    
    @IBOutlet weak var imageOfExercise: UIImageView!
    @IBOutlet weak var exerciseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let exercise = exerciseOfCell{
            set(exercise)
        }
        setLayer()
        setConstraint()
    }
    
    func setLayer(){
        imageOfExercise.layer.cornerRadius = imageOfExercise.frame.height / 2
        imageOfExercise.layer.borderWidth = 1
        imageOfExercise.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        imageOfExercise.layer.masksToBounds = true
    }
    func setConstraint() {
//        switch UIScreen.main.bounds.height {
//        case 568:
//            exerciseName.font = UIFont(name: "OpenSans-Light", size: 14)
//        default:
//            break
//        }
    }
    
    func set(_ exercise: Exercise) {
        self.exerciseName.text = exercise.name
        self.imageOfExercise.image = exercise.Image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
