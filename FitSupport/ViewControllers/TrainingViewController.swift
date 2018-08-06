//
//  TrainingViewController.swift
//  FitSupport
//
//  Created by Daulet on 01.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
class TrainingViewController : UIViewController {
    
    @IBOutlet weak var collectionOfWorkOutdays: UICollectionView!
    @IBOutlet weak var headerVeiw: UIView!
    @IBOutlet weak var kaloriesBurnedLabel: UILabel!
    @IBOutlet weak var weightBurnedLabel: UILabel!
    @IBOutlet weak var kaloriesImage: UIImageView!
    @IBOutlet weak var currentWeightImage: UIImageView!
    @IBOutlet weak var progressView: CircleProgressView!
    
    var currentDay: Day?
    private var _workoutOfCurrentTraining: Workout?
    
    override func viewWillAppear(_ animated: Bool) {
        if viewIfLoaded != nil{
            setData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomWorkout()
        if _workoutOfCurrentTraining == nil{
            performSegue(withIdentifier: "createWorkout", sender: nil)
        }
        else{
            navigationItem.title = _workoutOfCurrentTraining?.name
            collectionOfWorkOutdays.delegate = self
            collectionOfWorkOutdays.dataSource = self
            setData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        setPositionOfDay()
    }
    func setData(){
        currentDay = _workoutOfCurrentTraining?.currentDay()
        progressView.progress(percent: _workoutOfCurrentTraining?.completionRate() ?? 0)
        collectionOfWorkOutdays.reloadData()
    }
    func set(_ workout: Workout){
        _workoutOfCurrentTraining = workout
    }
    func setPositionOfDay(animated: Bool = false){
        if let day = currentDay,
           let dayCount = day.dayCount{
            let index:CGFloat = CGFloat(dayCount) - 1
            let layout = self.collectionOfWorkOutdays?.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpace = layout.itemSize.width + layout.minimumLineSpacing
            let point = CGPoint(x: index * cellWidthIncludingSpace - collectionOfWorkOutdays.contentInset.left, y: -collectionOfWorkOutdays.contentInset.top)
            
            collectionOfWorkOutdays.setContentOffset(point, animated: animated)
        }
    }
    func setCustomWorkout() {
        let day1 = Day(name: "Arm day", count: 2, exercises: [
                Exercise(name: "QAZAQ PRESS", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4)),
                Exercise(name: "DAUKA's JIM", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4))
            ])
        let exe = Exercise(name: "ASDF", description: "asdf", image: UIImage.gif(name: "vertikalnaya_tyaga"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4))
//        exe.exerciseState = .done
        let day2 = Day(name: "Arm day", count: 2, exercises: [
            Exercise(name: "JIM", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4)),
            Exercise(name: "DAUKA's JIM", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4))
            ])
        let day3 = Day(name: "Arm day", count: 2, exercises: [
            exe,exe,exe,exe,exe,exe,
            ])
        _workoutOfCurrentTraining = Workout(name: "BestWorkOut", and: [day1, day3, day2])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDayExercises"{
            if let trainingExerciseVC = segue.destination as? TrainingExerciseViewController{
                trainingExerciseVC.currentDay = currentDay
                trainingExerciseVC.delegateTraining = self
            }
        }
    }
}
extension TrainingViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _workoutOfCurrentTraining?.workoutDaysForMonth.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let trainingDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingDay", for: indexPath) as? TrainingDayCell else{
            return UICollectionViewCell()
        }
        if let day = _workoutOfCurrentTraining?.workoutDaysForMonth[indexPath.row]{
            let check = day.dayCount == currentDay?.dayCount
            print("\(day.dayCount!)   ==   \(currentDay?.dayCount!)  ->   \(check)")
            trainingDayCell.set(day, isCurrentDay: check)
        }
        trainingDayCell.dayExerciseDelegate = self
        return trainingDayCell
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectionOfWorkOutdays?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpace = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpace
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
}
extension TrainingViewController: TrainingDayCellDelegate, TrainingExerciseDelegate{
    func alertDayIsCompleted() {
        alert(with: "Программа уже закончена", and: "Вы уже проходили эту тренировку")
    }
    
    func alertNotCurrentDayPressed() {
        alert(with: "Программа не на сегодня", and: "Для достижения хороших результатов тренировочную программу надо выполнять по очередно")
    }
    
    func update(_ day: Day) {
        _workoutOfCurrentTraining?.update(day)
        collectionOfWorkOutdays.reloadData()
    }
    
    func startExercise() {
        performSegue(withIdentifier: "openDayExercises", sender: nil)
    }
}
extension UIViewController{
    func alert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
