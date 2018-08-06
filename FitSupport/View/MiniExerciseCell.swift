//
//  MiniCollectionOfExercises.swift
//  FitSupport
//
//  Created by Daulet on 03.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class MiniExerciseCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var isDone: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    func isCurrent(exercise: Bool){
        line.isHidden = !exercise
        self.addSubview(line)
        
    }
    lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 12, y: self.frame.height - 8, width: self.frame.width - 24, height: 2))
        line.layer.borderWidth = 0.5
        line.layer.borderColor = GlobalColors.lightyGray.color().cgColor
        line.backgroundColor = UIColor.white
        line.layer.cornerRadius = line.frame.height/2
        return line
    }()
    
    func set(_ exercise: Exercise){
        name.text = exercise.Name
        image.image = exercise.Image
        let _toHide = exercise.exerciseState != .done
        isDone.isHidden = _toHide
    }
    
}
