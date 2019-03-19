//
//  WorkoutViewController.swift
//  FitSupport
//
//  Created by Daulet on 01.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

class WorkoutViewController: UIViewController, Customizable {
    
    var currentWorkout: Workout? {
        didSet {
//            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    func commonInit() {
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = currentWorkout?.name
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let screenBounds = UIScreen.main.bounds
        let horizontalInset: CGFloat = 16
        let verticalInset: CGFloat = 16
        let navbarHeight: CGFloat = 49
        layout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        layout.minimumInteritemSpacing = CGFloat(24)
        layout.minimumLineSpacing = CGFloat(24)
        layout.itemSize = CGSize(width: screenBounds.width - (24 * 2 - 32), height: (screenBounds.height - navbarHeight - verticalInset * 2))
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beginTraining"{
            if let workout = currentWorkout{
                currentUser?.setCurrent(workout: workout)
            }
        }
    }
    
}

extension WorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let daysNumber = currentWorkout?.differentWorkoutDays.count else { return 1 }
        return daysNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutDayCell", for: indexPath) as? WorkoutDayCell else {return UICollectionViewCell()}
        guard let days = currentWorkout?.differentWorkoutDays else { return UICollectionViewCell() }
        
        let day = days[indexPath.row]
        day.dayCount = indexPath.row + 1
        dayCell.set(day)
        return dayCell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpace = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpace
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    
}
