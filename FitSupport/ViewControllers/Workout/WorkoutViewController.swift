//
//  WorkoutViewController.swift
//  FitSupport
//
//  Created by Daulet on 01.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

class WorkoutViewController: UIViewController, Customizable {
    
    var currentWorkout: Workout?
    
    @IBOutlet weak var tableOfExercises: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableOfExercises.reloadData()
    }
    
    func commonInit() {
        tableOfExercises.delegate = self
        tableOfExercises.dataSource = self
        navigationItem.title = currentWorkout?.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beginTraining"{
            if let workout = currentWorkout{
                currentUser?.setCurrent(workout: workout)
            }
        }
    }
    
}
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let daysNumber = currentWorkout?.differentWorkoutDays.count else { return 1 }
        return daysNumber
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "День \(currentWorkout?.differentWorkoutDays[section].dayCount ?? 0)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let exercisesInDayNumber = currentWorkout?.differentWorkoutDays else { return 0 }
        return exercisesInDayNumber[section].ExercisesOfDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "Workout", for: indexPath)
        let currentExercise = currentWorkout?.differentWorkoutDays[indexPath.section].ExercisesOfDay[indexPath.row]
        let currentTrainingSession = "\(currentExercise?.TrainingSession?.reps ?? 0) раза \(currentExercise?.TrainingSession?.times ?? 0) повт"
        
        exerciseCell.textLabel?.text = currentExercise?.name
        exerciseCell.detailTextLabel?.text = currentTrainingSession
        exerciseCell.set(color: UIColor.darkBlue)
        exerciseCell.detailTextLabel?.textColor = UIColor.lightyBlue
        
        return exerciseCell
    }
}
