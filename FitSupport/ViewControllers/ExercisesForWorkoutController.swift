//
//  ExercisesForWorkoutController.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
protocol ExercisesForWorkoutControllerDelegate: AnyObject {
    func addIntoDay(tableOf exercises: [Exercise])
}
class ExercisesForWorkoutController: ExercisesViewController, ExerciseForWorkoutCellDelegate {
    
    weak var delegateFromGenerateVC: ExercisesForWorkoutControllerDelegate?
    private var exercisesBasket: [Exercise] = []{
        didSet{
            print(exercisesBasket.count)
        }
    }
    var allExercises: [Exercise] = Exercises.getAll(){
        didSet{
            currentMuscleExercises = allExercises.filter({ ($0.MuscleType?.contains(allMuscleTypes[0])) ?? false })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allExercises = Exercises.getAll()
    }
    override func viewWillAppear(_ animated: Bool) {
        currentMuscleExercises = allExercises.filter({ ($0.MuscleType?.contains(allMuscleTypes[0])) ?? false })
    }
    func add(_ exercise: Exercise) {
        exercisesBasket.append(exercise)
    }
    func update(_ exercise: Exercise) {
        let index = getIndexOf(exercise, from: allExercises)
        allExercises[index] = exercise
    }
    func remove(_ exercise: Exercise) {
        let index = getIndexOf(exercise, from: exercisesBasket)
        exercisesBasket.remove(at: index)
    }
    override func viewWillDisappear(_ animated: Bool) {
        delegateFromGenerateVC?.addIntoDay(tableOf: exercisesBasket)
    }
}
extension ExercisesForWorkoutController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseForWorkoutCell", for: indexPath) as? ExerciseForWorkoutCell else{ return UITableViewCell() }
        
        let exercise = currentMuscleExercises[indexPath.row]
        exerciseCell.delegateExerciseBasket = self
        exerciseCell.setIntoCell(exercise)
        
        return exerciseCell
    }
    func getIndexOf(_ exercise: Exercise, from array: [Exercise]) -> Int{
        for i in 0..<array.count {
            if (array[i].Name == exercise.Name){
                return i
            }
        }
        return 0
    }
}
