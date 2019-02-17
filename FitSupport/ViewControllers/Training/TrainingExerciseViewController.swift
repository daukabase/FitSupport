//
//  TrainingExerciseViewController.swift
//  FitSupport
//
//  Created by Daulet on 03.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

protocol TrainingExerciseDelegate: AnyObject {
    func update(_ day: Day)
}
class TrainingExerciseViewController: ExerciseViewController {
    
    @IBOutlet weak var collectionOfExercises: UICollectionView!
    @IBOutlet weak var exerciseControlButton: UIButton!
    
    weak var delegateTraining: TrainingExerciseDelegate?
    
    @IBAction func exerciseControlButtonPressed(_ sender: UIButton){
        if self.currentDay?.currentExercise == nil{
            self.navigationController?.popViewController(animated: true)
        }else{
            UIView.animate(withDuration: 1) {
                self.currentDay?.nextExercise()
                self.setExercise()
                self.collectionOfExercises.reloadData()
            }
        }
    }
    
    var currentDay: Day?
    
    override func viewWillDisappear(_ animated: Bool) {
        if let day = currentDay{
            delegateTraining?.update(day)
        }
    }
    
    override func viewDidLoad() {
        if currentDay?.currentExercise == nil{
            currentDay?.beginThisDayTraining()
        }
        super.viewDidLoad()
        collectionOfExercises.delegate = self
        collectionOfExercises.dataSource = self
        exerciseControlButton.layer.cornerRadius = 16
        setExercise()
    }
    override func viewDidAppear(_ animated: Bool) {
        setLayer()
    }
    
    func setLayer(){
        exerciseControlButton.applySketchShadow()
    }
    func setExercise(){
        if let day = currentDay{
            navigationItem.title = day.dayName
            if let exer = day.currentExercise {
                imageOfExercise.image = exer.Image
                nameOfExercise.text = exer.name
                trainingSession.text = "\(exer.TrainingSession?.times ?? 0) раза \(exer.TrainingSession?.reps ?? 0) повт"
            }else{
                exerciseControlButton.setTitle("Закончить", for: .normal)
                exerciseControlButton.backgroundColor = UIColor.disablebColor
            }
        }
    }
}
extension TrainingExerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDay?.ExercisesOfDay.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let miniExerciseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniExercise", for: indexPath) as! MiniExerciseCell
        let miniExercise = currentDay!.ExercisesOfDay[indexPath.row]
        miniExerciseCell.set(miniExercise)
        miniExerciseCell.isCurrent(exercise:  miniExercise.exerciseState == .doing)
        
        return miniExerciseCell
    }
}

