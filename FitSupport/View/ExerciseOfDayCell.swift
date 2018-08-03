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
    }
    
    func setLayer(){
        imageOfExercise.layer.cornerRadius = imageOfExercise.frame.height / 2
        imageOfExercise.layer.borderWidth = 1
        imageOfExercise.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        imageOfExercise.layer.masksToBounds = true
    }
    
    func set(_ exercise: Exercise) {
        self.exerciseName.text = exercise.Name
        self.imageOfExercise.image = exercise.Image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
