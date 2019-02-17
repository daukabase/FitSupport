//
//  ExerciseOfDayCell.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ExerciseOfDayCell: UITableViewCell, Customizable {
    
    @IBOutlet weak var imageOfExercise: UIImageView!
    @IBOutlet weak var exerciseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    internal func commonInit() {
        imageOfExercise.layer.cornerRadius = imageOfExercise.frame.height / 2
        imageOfExercise.layer.borderWidth = 1
        imageOfExercise.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        imageOfExercise.layer.masksToBounds = true
    }
    
    func set(name: String?, image: UIImage?) {
        self.exerciseName.text = name
        self.imageOfExercise.image = image
    }
    
}
