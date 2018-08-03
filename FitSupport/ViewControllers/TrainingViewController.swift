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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOfWorkOutdays.delegate = self
        collectionOfWorkOutdays.dataSource = self
        setCustomWorkout()
        collectionOfWorkOutdays.reloadData()
        currentDay = _workoutOfCurrentTraining?.currentDay()
//        progressView.drawCircleInView(progress: 20, and: GlobalColors.darkBlue.color())
        progressView.progress(percent: 45)
    }
    override func viewDidAppear(_ animated: Bool) {
        setPositionOfDay()
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
    func set(_ workout: Workout){
        _workoutOfCurrentTraining = workout
    }
    func setCustomWorkout() {
        _workoutOfCurrentTraining = Workout(name: "BestWorkOut", and: [
            Day(name: "Arm day", count: 2, exercises: Exercises.filtered(by: .arm)),
            Day(name: "Leg day", count: 2, exercises: Exercises.filtered(by: .leg))
            ])
        
        var exe = Exercise(name: "ASDF", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4))
        exe.exerciseState = .done
        _workoutOfCurrentTraining?.add(new: exe) //allExercises[0].isDone = true
        _workoutOfCurrentTraining?.onlyForTest()
        
    }
    
}
extension TrainingViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _workoutOfCurrentTraining?.WorkoutDaysForMonth.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let trainingDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingDay", for: indexPath) as? TrainingDayCell else{return UICollectionViewCell()}
        if let day = _workoutOfCurrentTraining?.WorkoutDaysForMonth[indexPath.row]{
            trainingDayCell.set(day)
        }
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
