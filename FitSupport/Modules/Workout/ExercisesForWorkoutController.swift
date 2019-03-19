//
//  ExercisesForWorkoutController.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import AKPickerView

protocol ExercisesForWorkoutControllerDelegate: AnyObject {
    func addIntoDay(tableOf exercises: [Exercise])
}

class ExercisesForWorkoutController: ExercisesViewController {
    
    weak var delegateFromGenerateVC: ExercisesForWorkoutControllerDelegate?
    
    private var exercisesBasket: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allExercises = Exercises.getAll()
        currentMuscleExercises = allExercises.filter({ ($0.muscleType?.contains(allMuscleTypes[0])) ?? false })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegateFromGenerateVC?.addIntoDay(tableOf: exercisesBasket)
    }
    
}
extension ExercisesForWorkoutController: ExerciseForWorkoutCellDelegate {
    
    func add(_ exercise: Exercise) {
        exercisesBasket.append(exercise)
    }
    
    func update(_ exercise: Exercise) {
        let index = getIndexOf(exercise, from: allExercises)
        if index != -1 {
            allExercises[index] = exercise
        }
        currentMuscleExercises = filter(allExercises, by: allMuscleTypes[Int(musclePicker.selectedItem)])
        tableOfExercises.reloadData()
    }
    
    func remove(_ exercise: Exercise) {
        let index = getIndexOf(exercise, from: exercisesBasket)
        if index != -1 {
            exercisesBasket.remove(at: index)
        }
    }
}
extension ExercisesForWorkoutController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseForWorkoutCell", for: indexPath) as? ExerciseForWorkoutCell else { return UITableViewCell() }
        let exercise = currentMuscleExercises[indexPath.row]
        exerciseCell.delegateExerciseBasket = self
        exerciseCell.setIntoCell(exercise)
        exerciseCell.setupLayer()
        return exerciseCell
    }
    
    func getIndexOf(_ exercise: Exercise, from array: [Exercise]) -> Int {
        for i in 0..<array.count {
            if (array[i].name == exercise.name) {
                return i
            }
        }
        return -1
    }
}
