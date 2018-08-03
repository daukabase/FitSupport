//
//  TrainingDayCell.swift
//  FitSupport
//
//  Created by Daulet on 02.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class TrainingDayCell: UICollectionViewCell {
    
    private var exercises: [Exercise] = []
    
    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var tableOfExercisesIntraining: UITableView!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBAction func beginButtonPressed(){
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableOfExercisesIntraining.delegate = self
        tableOfExercisesIntraining.dataSource = self
        setLayer()
    }
    func set(_ day: Day){
        dayName.text = day.dayName
        exercises = day.allExercises
    }
    func setLayer() {
        beginButton.applySketchShadow()
        beginButton.layer.cornerRadius = 16
        self.applySketchShadow()
        containerView.layer.cornerRadius = 16
        self.layer.cornerRadius = 16
        self.layer.borderColor = GlobalColors.lightyBlue.color().cgColor
        self.layer.borderWidth = 0.3
    }
}

extension TrainingDayCell: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trainingExerciseCell = tableView.dequeueReusableCell(withIdentifier: "TrainingExercise", for: indexPath) as? TrainingExerciseCell else{
            return UITableViewCell()
        }
        var exercise = exercises[indexPath.row]
        if indexPath.row == 0 {
            exercise.exerciseState = .done
        }
        let isLastExercise = indexPath.row == exercises.count-1
        print("\(indexPath.row) and its state is \(isLastExercise)")
        trainingExerciseCell.set(exercise, position: indexPath.row, isLast: isLastExercise)
        
        return trainingExerciseCell
    }
    
    
}
