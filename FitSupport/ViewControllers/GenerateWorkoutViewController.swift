//
//  GenerateWorkoutViewController.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class GenerateWorkoutViewController: UIViewController, ExercisesForWorkoutControllerDelegate{
    
    func addIntoDay(tableOf exercises: [Exercise]) {
        if let index = indexOfDayToAddExercises{
            for exercise in exercises {
                daysOfWorkout[index].allExercises.append(exercise)
            }
            collectionWorkoutDays.reloadData()
        }
    }
    @IBOutlet weak var collectionWorkoutDays: UICollectionView!
    
    private var daysOfWorkout: [Day] = [
        Day()
    ]
    private var indexOfDayToAddExercises: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionWorkoutDays.delegate = self
        collectionWorkoutDays.dataSource = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let exercisesForWorkoutVC = segue.destination as? ExercisesForWorkoutController{
            exercisesForWorkoutVC.delegateFromGenerateVC = self
        }
    }
}

extension GenerateWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, WorkoutDayAddCellDelegate{
    func addExercisesWith(_ index: Int) {
        indexOfDayToAddExercises = index
        performSegue(withIdentifier: "ExercisesForWorkoutTable", sender: nil)
    }
    
    func generateAddCell() {
        daysOfWorkout.append(Day())
        collectionWorkoutDays.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfWorkout.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? WorkoutDayCell else {
            return UICollectionViewCell()
        }
        
        dayCell.workoutDayAddcellDelegate = self
        dayCell.layer.applySketchShadow()
        
        if indexPath.row != daysOfWorkout.count{
            var day = daysOfWorkout[indexPath.row]
            day.dayCount = indexPath.row + 1
            dayCell.set(day)
        }else{
            dayCell.isAddCell()
        }
        return dayCell
    }
}
