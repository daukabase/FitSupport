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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func add(_ exercise: Exercise) {
        exercisesBasket.append(exercise)
    }
    
    func remove(_ exercise: Exercise) {
        fromBasketRemove(exercise)
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
    func fromBasketRemove(_ exercise: Exercise){
        for i in 0..<exercisesBasket.count {
            if (exercisesBasket[i].Name == exercise.Name){
                exercisesBasket.remove(at: i)
                return
            }
        }
    }
}
