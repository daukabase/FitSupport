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
        line.frame = CGRect(x: name.frame.origin.x + name.frame.width/2, y: self.frame.height - 8, width: 0, height: 2)
        self.addSubview(line)
        UIView.animate(withDuration: 0.6) {
            self.line.frame.origin.x = self.name.frame.origin.x
            self.line.frame.size.width = self.name.frame.width
        }
    }
    lazy var line: UIView = {
        let line = UIView()
        line.layer.borderWidth = 0.5
        line.layer.borderColor = UIColor.lightyGray.cgColor
        line.backgroundColor = UIColor.white
        line.layer.cornerRadius = line.frame.height/2
        return line
    }()
    
    func set(_ exercise: Exercise){
        name.text = exercise.name
        image.image = exercise.Image
        let _toHide = exercise.exerciseState != .done
        isDone.isHidden = _toHide
    }
    
}
