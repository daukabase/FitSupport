//
//  WorkoutViewController.swift
//  FitSupport
//
//  Created by Daulet on 01.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableOfExercises: UITableView!
    var currentWorkout: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfExercises.delegate = self
        tableOfExercises.dataSource = self
        navigationItem.title = currentWorkout?.name
//        setCustomWorkout()
    }
    func setCustomWorkout() {
        currentWorkout = Workout(name: "BestWorkOut", and: [
            Day(name: "Arm day", count: 1, exercises: Exercises.filtered(by: .arm)),
            Day(name: "Leg day", count: 2, exercises: Exercises.filtered(by: .leg))
            ])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beginTraining"{
            if let trainingVC = segue.destination as? TrainingViewController,
                let workout = currentWorkout{
                trainingVC.set(workout)
            }
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "День \(currentWorkout?.WorkoutDaysForMonth[section].dayCount ?? 0)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let exercisesInDayNumber = currentWorkout?.differentWorkoutDays{
            return exercisesInDayNumber[section].allExercises.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let daysNumber = currentWorkout?.differentWorkoutDays.count{
            return daysNumber
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "Workout", for: indexPath)
        let currentDay = currentWorkout?.differentWorkoutDays[indexPath.section]
        let currentExercise = currentDay?.allExercises[indexPath.row]
        
        let currentTrainingSession = "\(currentExercise?.TrainingSession?.reps ?? 0) раза \(currentExercise?.TrainingSession?.times ?? 0) повт"
        
        exerciseCell.textLabel?.text = currentExercise?.Name
        exerciseCell.detailTextLabel?.text = currentTrainingSession
        exerciseCell.set(color: GlobalColors.darkBlue)
        exerciseCell.detailTextLabel?.textColor = GlobalColors.lightyBlue.color()
        
        return exerciseCell
    }
}
