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
    }
    override func viewWillAppear(_ animated: Bool) {
        tableOfExercises.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beginTraining"{
            if let workout = currentWorkout{
                currentUser?.setCurrent(workout: workout)
            }
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "День \(currentWorkout?.differentWorkoutDays[section].dayCount ?? 0)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let exercisesInDayNumber = currentWorkout?.differentWorkoutDays{
            return exercisesInDayNumber[section].ExercisesOfDay.count
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
        let currentExercise = currentWorkout?.differentWorkoutDays[indexPath.section].ExercisesOfDay[indexPath.row]
        let currentTrainingSession = "\(currentExercise?.TrainingSession?.reps ?? 0) раза \(currentExercise?.TrainingSession?.times ?? 0) повт"
        
        exerciseCell.textLabel?.text = currentExercise?.Name
        exerciseCell.detailTextLabel?.text = currentTrainingSession
        exerciseCell.set(color: GlobalColors.darkBlue)
        exerciseCell.detailTextLabel?.textColor = GlobalColors.lightyBlue.color()
        
        return exerciseCell
    }
}
