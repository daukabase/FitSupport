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
    
    @IBOutlet weak var tableOfWorkouts: UITableView!
    @IBOutlet weak var emptyWorkoutView: UIView!
    
    private var _allAvailableWorkouts : [Workout] = []
    
    weak var allAvailableWorkoutsDelegate: allAvailableWorkoutsDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        emptyWorkout()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfWorkouts.delegate = self
        tableOfWorkouts.dataSource = self
        fetchWorkoutsFromRealmDatabase()
    }
    func fetchWorkoutsFromRealmDatabase(){
        Workout.fetchAllWorkouts { (workouts) in
            self._allAvailableWorkouts = workouts
            self.emptyWorkout()
            self.tableOfWorkouts.reloadData()
        }
    }
    
    func set(new workout: Workout) {
        _allAvailableWorkouts.append(workout)
        let newWorkout = Workout(id: workout.id, name: workout.name, daysForMonth: workout.WorkoutDaysForMonth, differentDays: workout.differentWorkoutDays)
        newWorkout.writeToRealm()
    }
    
    func emptyWorkout(){
        let hasallAvailableWorkouts = (_allAvailableWorkouts.count != 0)
        tableOfWorkouts.isHidden = !hasallAvailableWorkouts
        emptyWorkoutView.isHidden = hasallAvailableWorkouts
        tableOfWorkouts.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "generateWorkout"{
            if let generateWorkoutVC = segue.destination as? GenerateWorkoutViewController{
                generateWorkoutVC.setWorkoutDelegate = self
            }
        }
        else if segue.identifier == "workoutController"{
            if let generateWorkoutVC = segue.destination as? WorkoutViewController{
                if let index = tableOfWorkouts.indexPathForSelectedRow?.row{
                    generateWorkoutVC.currentWorkout = _allAvailableWorkouts[index]
                }
            }
        }
    }
}
extension WorkoutsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _allAvailableWorkouts.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(with: .confirmation, title: "Вы уверены что хотите выйти", message: "После выхода из системы ваши данные будут утрачены") { [weak self] in
                self?._allAvailableWorkouts[indexPath.row].deleteFromRealm()
                self?._allAvailableWorkouts.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workoutCell = tableView.dequeueReusableCell(withIdentifier: "Workout", for: indexPath)
        workoutCell.textLabel?.text = _allAvailableWorkouts[indexPath.row].name
        workoutCell.detailTextLabel?.text = "\(_allAvailableWorkouts[indexPath.row].completionRate()) %"
        workoutCell.set(color: GlobalColors.darkBlue)
        return workoutCell
    }
}
extension UITableViewCell{
    func set(color: GlobalColors){
        self.textLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
        self.textLabel?.textColor = color.color()
        self.detailTextLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
        self.detailTextLabel?.textColor = color.color()
    }
}
