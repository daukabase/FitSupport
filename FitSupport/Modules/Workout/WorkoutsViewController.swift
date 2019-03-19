//
//  allAvailableWorkoutsViewController.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
protocol allAvailableWorkoutsDelegate: AnyObject {
    func forCurrentUserUpdate(_ allAvailableWorkouts: [Workout])
}
class WorkoutsViewController: UIViewController, SetGeneratedWorkoutDelegate {
    
    
    weak var allAvailableWorkoutsDelegate: allAvailableWorkoutsDelegate?
    
    private var workouts: [Workout] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyWorkoutView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchWorkoutsFromRealmDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emptyWorkout()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func fetchWorkoutsFromRealmDatabase() {
        Workout.fetchAllWorkouts { (workouts) in
            self.workouts = workouts
            self.emptyWorkout()
            self.tableView.reloadData()
        }
    }
    
    func set(new workout: Workout) {
        workouts.append(workout)
        let newWorkout = Workout(id: workout.id, name: workout.name, daysForMonth: workout.WorkoutDaysForMonth, differentDays: workout.differentWorkoutDays)
        newWorkout.writeToRealm()
    }
    
    func emptyWorkout() {
        let hasallAvailableWorkouts = (workouts.count != 0)
        tableView.isHidden = !hasallAvailableWorkouts
        emptyWorkoutView.isHidden = hasallAvailableWorkouts
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "generateWorkout" {
            if let generateWorkoutVC = segue.destination as? GenerateWorkoutViewController {
                generateWorkoutVC.setWorkoutDelegate = self
            }
        }
        else if segue.identifier == "workoutController" {
            if let generateWorkoutVC = segue.destination as? WorkoutViewController,
                let index = tableView.indexPathForSelectedRow?.row {
                generateWorkoutVC.currentWorkout = workouts[index]
            }
        }
    }
}
extension WorkoutsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let title = "Вы уверены что хотите выйти"
            let message = "После выхода из системы ваши данные будут утрачены"
            showAlert(with: .confirmation, title: title, message: message) { [weak self, weak tableView] in
                self?.workouts[indexPath.row].deleteFromRealm()
                self?.workouts.remove(at: indexPath.row)
                tableView?.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workoutCell = tableView.dequeueReusableCell(withIdentifier: "Workout", for: indexPath)
        workoutCell.textLabel?.text = workouts[indexPath.row].name
        workoutCell.detailTextLabel?.text = "\(workouts[indexPath.row].completionRate()) %"
        workoutCell.set(color: UIColor.darkBlue)
        return workoutCell
    }
    
}
