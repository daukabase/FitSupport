//
//  TrainingDayCell.swift
//  FitSupport
//
//  Created by Daulet on 02.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
protocol TrainingDayCellDelegate: AnyObject {
    func startExercise()
    func alertNotCurrentDayPressed()
    func alertDayIsCompleted()
}
class TrainingDayCell: UICollectionViewCell {
    
    private var exercises: [Exercise] = []{
        didSet{
            tableOfExercisesIntraining.reloadData()
        }
    }
    weak var dayExerciseDelegate: TrainingDayCellDelegate?
    
    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var tableOfExercisesIntraining: UITableView!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dayIsDone: UIImageView!
    private var dayIsCompleted = false
    private var isCurrentDay = false
    
    @IBAction func beginButtonPressed(){
        if !dayIsCompleted{
            if !isCurrentDay{
                dayExerciseDelegate?.alertNotCurrentDayPressed()
            }
            else{
                dayExerciseDelegate?.startExercise()
            }
        }else{
            dayExerciseDelegate?.alertDayIsCompleted()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableOfExercisesIntraining.delegate = self
        tableOfExercisesIntraining.dataSource = self
        dayIsDone.isHidden = true
    }
    func set(_ day: Day, isCurrentDay: Bool = false){
        dayName.text = "\(day.dayCount ) день ( \(day.dayName ) )"
        dayIsCompleted = day.isCompleted()
        dayIsDone.isHidden = !dayIsCompleted
        self.isCurrentDay = isCurrentDay
        if dayIsCompleted {
            setBeginButtonLayers(background: UIColor.white, title: "сделано", and: GlobalColors.lightyBlue.color())
        }else if !isCurrentDay{
            setBeginButtonLayers(background: GlobalColors.disablebColor.color(), title: "начать", and: UIColor.white)
        }else{
            setBeginButtonLayers(background: GlobalColors.lightyBlue.color(), title: "начать", and: UIColor.white)
        }
        tableOfExercisesIntraining.reloadData()
        exercises = day.ExercisesOfDay
    }
    func setBeginButtonLayers(background color: UIColor, title content: String, and titleColor: UIColor){
        beginButton.setTitle(content, for: .normal)
        beginButton.setTitleColor(titleColor, for: .normal)
        beginButton.backgroundColor = color
    }
    func setLayer() {
        beginButton.applySketchShadow()
        beginButton.layer.borderColor = GlobalColors.lightyGray.color().cgColor
        beginButton.layer.borderWidth = 0.5
        beginButton.layer.cornerRadius = 16
        
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
        let exercise = exercises[indexPath.row]
        let isLastExercise = indexPath.row == exercises.count - 1
        trainingExerciseCell.set(exercise, position: indexPath.row, isLast: isLastExercise, dayIsCompleted: dayIsCompleted)
        
        return trainingExerciseCell
    }
}
