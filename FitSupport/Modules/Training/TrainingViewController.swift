//
//  TrainingViewController.swift
//  FitSupport
//
//  Created by Daulet on 01.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TrainingViewController: UIViewController, UIGestureRecognizerDelegate, Customizable {
    
    var currentDay: Day?
    
    private var _workoutOfCurrentTraining: Workout? {
        didSet {
            _workoutOfCurrentTraining?.updateInRealm()
            resetWorkoutStates()
        }
    }
    
    @IBOutlet weak var collectionOfWorkOutdays: UICollectionView!
    @IBOutlet weak var headerVeiw: UIView!
    @IBOutlet weak var kaloriesBurnedLabel: UILabel!
    @IBOutlet weak var weightBurnedLabel: UILabel!
    @IBOutlet weak var kaloriesImage: UIImageView!
    @IBOutlet weak var currentWeightButton: UIButton!
    @IBOutlet weak var progressView: CircleProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        fetchUser()
        setLayout()
    }
    
    func commonInit() {
        collectionOfWorkOutdays.delegate = self
        collectionOfWorkOutdays.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if _workoutOfCurrentTraining == nil && currentUser != nil {
            checkUpUserInfo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setPositionOfDay()
        collectionOfWorkOutdays.reloadData()
    }
    
    @IBAction func updateWeightOfCurrentUser() {
        performSegue(withIdentifier: "updateWeight", sender: nil)
    }
    
    @IBAction func finishWorkoutViewController(){
        completeCurrentWorkout()
    }
    
    func completeCurrentWorkout() {
        let alert = UIAlertController(title: "Покинуть данную тренировку", message: "Вы можете перейти на список своих тренировок. При этом вы можете потерять свои некоторые данные", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "createWorkout", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let screenBounds = UIScreen.main.bounds
        let horizontalInset = screenBounds.width * (38 / 375)
        let verticalInset = screenBounds.height * (16 / 812)
        let tabbarHeight:CGFloat = 49
        let navbarHeight:CGFloat = 49
        let workoutStateViewHeight:CGFloat = headerVeiw.frame.height
        layout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        layout.minimumInteritemSpacing = CGFloat(24)
        layout.minimumLineSpacing = CGFloat(24)
        layout.itemSize = CGSize(width: screenBounds.width - horizontalInset * 2, height: (screenBounds.height - tabbarHeight - navbarHeight - bottomPaddingOfView() - topPaddingOfView() - workoutStateViewHeight - verticalInset * 2 - 24))
        layout.scrollDirection = .horizontal
        collectionOfWorkOutdays.setCollectionViewLayout(layout, animated: false)
    }
    
    func topPaddingOfView() -> CGFloat {
        switch UIScreen.main.bounds.height {
        case 812:
            return 44
        default:
            return 20
        }
    }
    func bottomPaddingOfView() -> CGFloat {
        switch UIScreen.main.bounds.height {
        case 812:
            return 34
        default:
            return 0
        }
    }
    func fetchUser() {
        User.ifUserExist { [weak self] (user) in
            currentUser = user
            self?.checkUpUserInfo()
        }
    }
    func checkUpUserInfo() {
        if let currentUser = currentUser {
            _workoutOfCurrentTraining = Workout.fetchCurrentWorkout(of: currentUser)
            if _workoutOfCurrentTraining == nil {
                self.performSegue(withIdentifier: "createWorkout", sender: nil)
            } else {
                resetCurrentDay()
                navigationItem.title = _workoutOfCurrentTraining?.name
                resetWorkoutStates()
                collectionOfWorkOutdays.reloadData()
            }
        } else {
            self.performSegue(withIdentifier: "signUp", sender: nil)
        }
    }
    
    func resetWorkoutStates() {
        if let currentUser = currentUser {
            progressView.setProgress(percent: (_workoutOfCurrentTraining?.completionRate()) ?? 0)
            weightBurnedLabel.text = "\(currentUser.currentWeight ?? 0) кг"
        }
    }
    
    func resetCurrentDay() {
        let toBeCurrentDay = _workoutOfCurrentTraining!.getCurrenDay()
        currentDay = Day()
        currentDay?.dayName = toBeCurrentDay.dayName
        currentDay?.dayCount = toBeCurrentDay.dayCount
        currentDay?.dayExersises = toBeCurrentDay.dayExersises
        currentDay?.castExercises()
    }
    
    
    func setPositionOfDay(animated: Bool = false) {
        if let day = currentDay {
            let dayCount = day.dayCount
            let index:CGFloat = CGFloat(dayCount) - 1
            let layout = self.collectionOfWorkOutdays?.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpace = layout.itemSize.width + layout.minimumLineSpacing
            let point = CGPoint(x: index * cellWidthIncludingSpace - collectionOfWorkOutdays.contentInset.left, y: -collectionOfWorkOutdays.contentInset.top)
            collectionOfWorkOutdays.setContentOffset(point, animated: animated)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDayExercises" {
            if let trainingExerciseVC = segue.destination as? TrainingExerciseViewController{
                trainingExerciseVC.delegateTraining = self
                trainingExerciseVC.currentDay = currentDay
            }
        } else if segue.identifier == "updateWeight" {
            if let updateWeight = segue.destination as? UpdateWeightViewController{
                updateWeight.updateDelegate = self
            }
        }
    }
    
}
extension TrainingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _workoutOfCurrentTraining?.WorkoutDaysForMonth.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let trainingDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingDay", for: indexPath) as? TrainingDayCell else {
            return UICollectionViewCell()
        }
        if let day = _workoutOfCurrentTraining?.WorkoutDaysForMonth[indexPath.row] {
            let check = day.dayCount == currentDay?.dayCount
            trainingDayCell.set(day, isCurrentDay: check)
        }
        trainingDayCell.setLayer()
//        trainingDayCell.layer.masksToBounds = false
        
//        trainingDayCell.applySketchShadow()
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
extension TrainingViewController: TrainingDayCellDelegate, TrainingExerciseDelegate, UpdateWeightDelegate {
    
    func updateWeight() {
        resetWorkoutStates()
    }
    
    func alertDayIsCompleted() {
        showAlert(with: .simple, title: "Программа уже закончена", message: "Вы уже проходили эту тренировку", onPress: nil)
    }
    
    func alertNotCurrentDayPressed() {
        showAlert(with: .simple, title: "Программа не на сегодня", message: "Для достижения хороших результатов тренировочную программу надо выполнять по очередно", onPress: nil)
    }
    
    func update(_ day: Day) {
        _workoutOfCurrentTraining?.update(day)
        resetCurrentDay()
        progressView.setProgress(percent: (_workoutOfCurrentTraining?.completionRate()) ?? 0)
        collectionOfWorkOutdays.reloadData()
    }
    
    func startExercise() {
        performSegue(withIdentifier: "openDayExercises", sender: nil)
    }
    
}
