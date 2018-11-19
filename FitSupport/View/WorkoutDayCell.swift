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
    func update(_ name: String, of dayIndex: Int)
}

class WorkoutDayCell: UICollectionViewCell, UITextFieldDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableOfExercisesPerDay.delegate = self
        tableOfExercisesPerDay.dataSource = self
        checkIfTableIsEmpty()
        setConstraints()
    }
    
    var exercises: [Exercise] = []{
        didSet{
            checkIfTableIsEmpty()
            tableOfExercisesPerDay.reloadData()
        }
    }
    
    @IBOutlet weak var tableOfExercisesPerDay: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dayCount: UILabel!
    @IBOutlet weak var addDay: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addDayView: UIView!
    @IBOutlet weak var addExercise: UIButton!
    @IBOutlet weak var dayNameEdit: UITextField!
    @IBOutlet weak var tableIsEmptyMessage: UILabel!
    
    weak var workoutDayAddcellDelegate: WorkoutDayAddCellDelegate?
    
    private var currentDay: Day?
    private var heightOfTableCell: CGFloat = 58
    
    @IBAction func addExercisesButtonPressed(){
        if let day = currentDay{
            workoutDayAddcellDelegate?.addExercisesWith(day.dayCount - 1)
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
            dayCount.text = dayNameEdit.text
        }
        else {
            sender.setTitle("Готово", for: .normal)
            dayNameEdit.text = dayCount.text
        }
        if let currentDay = currentDay, let name = dayCount.text{
            workoutDayAddcellDelegate?.update(name, of: currentDay.dayCount)
        }
        dayNameEdit.isHidden = isEditing
        dayCount.isHidden = !isEditing
    }
    func setConstraints(){
        let screenBounds = UIScreen.main.bounds
        dayCount.font = UIFont(name: "OpenSans-Bold", size: 20)
        tableIsEmptyMessage.font = UIFont(name: "OpenSans", size: screenBounds.height*20/812)
        editButton.titleLabel?.font = UIFont(name: "OpenSans", size: 17)
        addExercise.titleLabel?.font = UIFont(name: "OpenSans", size: screenBounds.height*17/812)
    }
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        dayNameEdit.isHidden = true
        dayCount.isHidden = false
        dayCount.text = dayNameEdit.text
        return true
    }
    
    func setLayer(){
        self.layer.cornerRadius = 16
        self.layer.applySketchShadow()
        
        dayNameEdit.delegate = self
        dayNameEdit.isHidden = true
    }
    func checkIfTableIsEmpty(){
        let tableIsEmpty = exercises.count == 0
        tableOfExercisesPerDay.isHidden = tableIsEmpty
        tableIsEmptyMessage.isHidden = !tableIsEmpty
        tableOfExercisesPerDay.layer.masksToBounds = true
    }
    func isAddCell(check: Bool = true) {
        addDayView.isHidden = !check
        checkIfTableIsEmpty()
    }
    func set(_ day: Day){
        if day.dayName != ""{
            dayCount.text = day.dayName
        }else{
            dayCount.text = "День \(String(day.dayCount))"
        }
        self.exercises = day.ExercisesOfDay
        currentDay = day
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIScreen.main.bounds.height {
            case 812:
                return 58
            case 568:
                return 48
            default:
                return 58
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            exercises.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.exercises[sourceIndexPath.row]
        exercises.remove(at: sourceIndexPath.row)
        exercises.insert(movedObject, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(String(describing: tableOfExercisesPerDay))")
    }
}

