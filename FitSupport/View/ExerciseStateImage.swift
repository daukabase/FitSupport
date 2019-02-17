//
//  exerciseStateImage.swift
//  FitSupport
//
//  Created by Daulet on 02.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
class ExerciseStateImage: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(countOfExerciseLabel)
        self.sendSubview(toBack: countOfExerciseLabel)
        self.addSubview(backgroundImage)
        self.sendSubview(toBack: backgroundImage)
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        
        
    }
    lazy var countOfExerciseLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.font = UIFont(name: "OpenSans-Bold", size: 10)
        label.textColor = GlobalColors.whity.color()
        label.textAlignment = .center
        return label
    }()
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(frame: self.bounds)
        image.contentMode = UIViewContentMode.scaleAspectFit
        return image
    }()
    func set(_ state:ExerciseState, count: Int = 0){
        switch state {
            case .done:
                countOfExerciseLabel.isHidden = true
            default:
                countOfExerciseLabel.isHidden = false
        }
        print("STATE   \(state)")
        backgroundImage.image = state.getImage()
        countOfExerciseLabel.text = "\(count + 1)"
    }
}
