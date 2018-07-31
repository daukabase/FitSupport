//
//  WorkoutCollectionView.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

protocol WorkoutDayAddCellDelegate: AnyObject {
    func generateAddCell()
    func addExercisesWith(_ index: Int)
}

class WorkoutDayCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableOfExercisesPerDay.delegate = self
        tableOfExercisesPerDay.dataSource = self
        setLayer()
    }
    
    var exercises: [Exercise] = Exercises.getAll(){
        didSet{
            tableOfExercisesPerDay.reloadData()
        }
    }
    
    @IBOutlet weak var tableOfExercisesPerDay: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dayCount: UILabel!
    @IBOutlet weak var addDay: UIButton!
    
    weak var workoutDayAddcellDelegate: WorkoutDayAddCellDelegate?
    private var currentDay: Day?
    
    @IBAction func addExercisesButtonPressed(){
        if let day = currentDay, let index = (day.dayCount){
            workoutDayAddcellDelegate?.addExercisesWith(index - 1)
        }
    }
    
    @IBAction func addDay(_ sender: UIButton){
        isAddCell(check: false)
        workoutDayAddcellDelegate?.generateAddCell()
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton){
        let isEditing = tableOfExercisesPerDay.isEditing
        tableOfExercisesPerDay.isEditing = !isEditing
        if isEditing {
            sender.setTitle("Изменить", for: .normal)
        }
        else {
            sender.setTitle("Готово", for: .normal)
        }
    }
    
    func setLayer(){
        self.layer.cornerRadius = 16
        self.layer.applySketchShadow()
    }
    func isAddCell(check: Bool = true) {
        tableOfExercisesPerDay.isHidden = check
        addDay.isHidden = !check
        headerView.isHidden = check
    }
    func set(_ day: Day){
        if let forCurrentDay = day.allExercises {
            self.exercises = forCurrentDay
        }
        dayCount.text = "День \(String(day.dayCount ?? 0))"
    }
}

extension WorkoutDayCell: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let workoutDayCell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as? ExerciseOfDayCell{
            workoutDayCell.set(exercises[indexPath.row])
            return workoutDayCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.exercises[sourceIndexPath.row]
        exercises.remove(at: sourceIndexPath.row)
        exercises.insert(movedObject, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(tableOfExercisesPerDay)")
        // To check for correctness enable: self.tableView.reloadData()
    }
}

