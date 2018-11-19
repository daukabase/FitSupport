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
        setLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        swipeViewToGoBack(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let exercisesForWorkoutVC = segue.destination as? ExercisesForWorkoutController {
            exercisesForWorkoutVC.delegateFromGenerateVC = self
        }
    }
    
    @IBAction func generateWorkout(){
        if !checkIfWorkoutHasEmptyDays() {
            setWorkoutAndItsName()
        } else{
            showAlert(with: .simple, title: "Пустой Workout", message: "Вы не выбрали упражнения", onPress: nil)
        }
    }
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let screenBounds = UIScreen.main.bounds
        let horizontalInset = screenBounds.width * (38 / 375)
        let verticalInset = screenBounds.height * (16 / 812)
        let tabbarHeight:CGFloat = 49
        let navbarHeight:CGFloat = 49
        layout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        layout.minimumInteritemSpacing = CGFloat(24)
        layout.minimumLineSpacing = CGFloat(24)
        layout.itemSize = CGSize(width: screenBounds.width - horizontalInset*2, height: (screenBounds.height - tabbarHeight - navbarHeight - bottomPaddingOfView() - topPaddingOfView() - verticalInset*2))
        layout.scrollDirection = .horizontal
        collectionWorkoutDays.setCollectionViewLayout(layout, animated: false)
    }
    func topPaddingOfView() -> CGFloat{
        switch UIScreen.main.bounds.height {
        case 812:
            return 44
        default:
            return 20
        }
    }
    func bottomPaddingOfView() -> CGFloat{
        switch UIScreen.main.bounds.height {
        case 812:
            return 34
        default:
            return 0
        }
    }
    func checkIfWorkoutHasEmptyDays() -> Bool {
        for dayIndex in 0..<daysOfWorkout.count{
            if daysOfWorkout[dayIndex].ExercisesOfDay.count == 0 {
                return true
            }
        }
        return false
    }
    func addIntoDay(tableOf exercises: [Exercise]) {
        if let index = indexOfDayToAddExercises {
            for exercise in exercises {
                daysOfWorkout[index].add(new: exercise)
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

extension GenerateWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, WorkoutDayAddCellDelegate {
    func update(_ name: String, of dayIndex: Int) {
        daysOfWorkout[dayIndex - 1].dayName = name
    }
    
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
            let day = daysOfWorkout[indexPath.row]
            day.dayCount = indexPath.row + 1
            dayCell.set(day)
            dayCell.applySketchShadow()
            dayCell.isAddCell(check: false)
        }
        else{
            dayCell.isAddCell()
        }
        dayCell.setLayer()
        return dayCell
    }
}
extension GenerateWorkoutViewController {
    func setWorkoutAndItsName() {
        let alert = UIAlertController(title: "Workout", message: "Напиши название для своей тренировки", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Workout"
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { [weak alert] (_) in
            
            let textField = alert?.textFields![0]
            let workoutID = UUID().uuidString
            let workout = Workout()
            
            workout.id = workoutID
            workout.name = (textField?.text)!
            workout.generateWorkoutMonthFrom(self.daysOfWorkout)
            
            self.setWorkoutDelegate?.set(new: workout)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
