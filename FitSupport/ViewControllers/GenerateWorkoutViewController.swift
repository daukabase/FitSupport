//
//  GenerateWorkoutViewController.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
protocol SetGeneratedWorkoutDelegate: AnyObject {
    func set(new workout: Workout)
}
class GenerateWorkoutViewController: UIViewController, ExercisesForWorkoutControllerDelegate{
    
    @IBOutlet weak var collectionWorkoutDays: UICollectionView!
    weak var setWorkoutDelegate: SetGeneratedWorkoutDelegate?
    
    private var daysOfWorkout: [Day] = [
        Day()
    ]
    private var indexOfDayToAddExercises: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionWorkoutDays.delegate = self
        collectionWorkoutDays.dataSource = self
        swipeViewToGoBack(false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        swipeViewToGoBack(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let exercisesForWorkoutVC = segue.destination as? ExercisesForWorkoutController{
            exercisesForWorkoutVC.delegateFromGenerateVC = self
        }
    }
    
    @IBAction func generateWorkout(){
        if checkIsWorkoutEmpty() {
            setWorkoutDelegate?.set(new: Workout(name: "SomeName", and: daysOfWorkout))
            navigationController?.popViewController(animated: true)
        }else{
            alert(with: "Empty Workout", and: "You didn't choose exercises")
        }
    }
    func alert(with title:String, and message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func checkIsWorkoutEmpty() -> Bool {
        for day in daysOfWorkout {
            if day.allExercises.count > 0 {
                return true
            }
        }
        return false
    }
    func addIntoDay(tableOf exercises: [Exercise]) {
        if let index = indexOfDayToAddExercises{
            for exercise in exercises {
                daysOfWorkout[index].add(new: exercise)//.allExercises.append(exercise)
            }
            collectionWorkoutDays.reloadData()
        }
    }
    
    func swipeViewToGoBack(_ sender: Bool){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = sender
    }
    func addExercisesWith(_ index: Int) {
        performSegue(withIdentifier: "goToExerciseSegue", sender: nil)
        indexOfDayToAddExercises = index
    }
    
    func generateAddCell() {
        daysOfWorkout.append(Day())
        collectionWorkoutDays.reloadData()
    }
    
}

extension GenerateWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, WorkoutDayAddCellDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionWorkoutDays?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpace = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpace
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
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
            dayCell.isAddCell(check: false)
        }
        else{
            dayCell.isAddCell()
        }
        return dayCell
    }
}
