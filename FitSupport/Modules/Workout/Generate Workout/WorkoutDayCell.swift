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
    func remove(day: Day?)
}

class WorkoutDayCell: UICollectionViewCell, Customizable {
    
    var exercises: [Exercise] = [] {
        didSet {
            checkIfTableIsEmpty()
            tableView.reloadData()
        }
    }
    
    weak var delegate: WorkoutDayAddCellDelegate?
    
    private var currentDay: Day?
    private var heightOfTableCell: CGFloat = 58
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dayCount: UILabel!
    @IBOutlet weak var addDay: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addDayView: UIView!
    @IBOutlet weak var addExercise: UIButton!
    @IBOutlet weak var dayNameEdit: UITextField!
    @IBOutlet weak var tableIsEmptyMessage: UILabel!
    @IBOutlet weak var removeDayButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        checkIfTableIsEmpty()
    }
    
    func commonInit() {
        tableView.delegate = self
        tableView.dataSource = self
        
        dayNameEdit.delegate = self
        dayNameEdit.isHidden = true
        
        removeDayButton.imageView?.contentMode = .scaleAspectFit
        removeDayButton.isHidden = true
        
        dayCount.font = UIFont(.bold, withSize: 20)
        tableIsEmptyMessage.font = UIFont(.regular, withSize: 20)
        editButton.titleLabel?.font = UIFont(.bold, withSize: 14)
        addExercise.titleLabel?.font = UIFont(.regular, withSize: 17)
    }
    
    func setupLayer() {
        [self, contentView, addDayView].forEach { $0?.layer.cornerRadius = 16 }
        layer.masksToBounds = false
        dropShadow(color: .black, alpha: 0.5, x: 2, y: 5, blur: 25, spread: -6)
    }
    
    @IBAction func addExercisesButtonPressed() {
        if let day = currentDay {
            delegate?.addExercisesWith(day.dayCount - 1)
        }
    }
    
    @IBAction func addDay(_ sender: UIButton) {
        isAddCell(check: false)
        delegate?.generateAddCell()
    }
    
    @IBAction func removeDayButtonDidClicked() {
        delegate?.remove(day: currentDay)
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        tableView.isEditing.toggle()
        // TODO: localize
        if !tableView.isEditing {
            sender.setTitle("Изменить", for: .normal)
            dayCount.text = dayNameEdit.text
            removeDayButton.isHidden = true
            dayNameEdit.resignFirstResponder()
        } else {
            sender.setTitle("Готово", for: .normal)
            dayNameEdit.text = dayCount.text
            removeDayButton.isHidden = false
        }
        if let currentDay = currentDay, let name = dayCount.text {
            delegate?.update(name, of: currentDay.dayCount)
        }
        dayNameEdit.isHidden = !tableView.isEditing
        dayCount.isHidden = tableView.isEditing
    }
    
    func checkIfTableIsEmpty() {
        let tableIsEmpty = exercises.count == 0
        tableView.isHidden = tableIsEmpty
        tableIsEmptyMessage.isHidden = !tableIsEmpty
        tableView.layer.masksToBounds = true
    }
    
    func isAddCell(check: Bool = true) {
        addDayView.isHidden = !check
        checkIfTableIsEmpty()
    }
    
    func set(_ day: Day) {
        if day.dayName != "" {
            dayCount.text = day.dayName
        } else {
            // TODO: localize
            dayCount.text = "День \(String(day.dayCount))"
        }
        exercises = day.ExercisesOfDay
        currentDay = day
    }
    
}

extension WorkoutDayCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let workoutDayCell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as? ExerciseOfDayCell {
            let exercise = exercises[indexPath.row]
            workoutDayCell.set(name: exercise.name, image: exercise.Image)
            return workoutDayCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIScreen.main.bounds.height {
            case 568:
                return 48
            default:
                return 58
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exercises.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.exercises[sourceIndexPath.row]
        exercises.remove(at: sourceIndexPath.row)
        exercises.insert(movedObject, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(String(describing: tableView))")
    }
    
}

extension WorkoutDayCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        dayNameEdit.isHidden = true
        dayCount.isHidden = false
        dayCount.text = dayNameEdit.text
        return true
    }
    
}
