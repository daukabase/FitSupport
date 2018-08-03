//
//  WorkoutsViewController.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController, SetGeneratedWorkoutDelegate {
    
    @IBOutlet weak var tableOfWorkouts: UITableView!
    @IBOutlet weak var emptyWorkoutView: UIView!
    private var workouts : [Workout] = []
    
    override func viewWillAppear(_ animated: Bool) {
        emptyWorkout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfWorkouts.delegate = self
        tableOfWorkouts.dataSource = self
        navigationItem.backBarButtonItem?.tintColor = GlobalColors.lightyBlue.color()
    }
    func set(new workout: Workout) {
        workouts.append(workout)
    }
    
    func emptyWorkout(){
        let hasWorkouts = (workouts.count != 0)
        tableOfWorkouts.isHidden = !hasWorkouts
        emptyWorkoutView.isHidden = hasWorkouts
        tableOfWorkouts.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "generateWorkout"{
            if let generateWorkoutVC = segue.destination as? GenerateWorkoutViewController{
                generateWorkoutVC.setWorkoutDelegate = self
            }
        }else if segue.identifier == "workoutController"{
            if let generateWorkoutVC = segue.destination as? WorkoutViewController{
                if let index = tableOfWorkouts.indexPathForSelectedRow?.row{
                    generateWorkoutVC.currentWorkout = workouts[index]
                }
            }
        }
    }
}
extension WorkoutsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workoutCell = tableView.dequeueReusableCell(withIdentifier: "Workout", for: indexPath)
        workoutCell.textLabel?.text = workouts[indexPath.row].name
        workoutCell.detailTextLabel?.text = "\(workouts[indexPath.row].completionRate()) %"
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
