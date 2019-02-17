//
//  ExerciseViewController.swift
//  FitSupport
//
//  Created by Daulet on 30.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import AKPickerView
import Cartography

class ExercisesViewController: UIViewController {
    
    let heightOfCell: CGFloat = 76
    
    var allMuscleTypes: [MuscleType] = [.arm, .chest, .back, .abs, .shoulders, .leg]
    
    var allExercises: [Exercise] = Exercises.getAll()
    
    var currentMuscleExercises: [Exercise] = [] {
        didSet {
            tableOfExercises.reloadData()
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var muscleName: UILabel!
    @IBOutlet weak var tableOfExercises: UITableView!
    
    lazy var musclePicker: AKPickerView = {
        let picker = AKPickerView(frame: view.frame)
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setConstraints()
        tableOfExercises.delegate = self
        tableOfExercises.dataSource = self
        currentMuscleExercises = filter(allExercises, by: allMuscleTypes[0])
    }
    
    func setConstraints() {
        constrain(musclePicker, muscleName, containerView, tableOfExercises) { (m, mn, cv, t) in
            m.top == mn.bottom + 8
            m.left == cv.left
            m.right == cv.right
            m.height == UIScreen.main.bounds.height / 8
            t.top == m.bottom + 8
            t.left == cv.left
            t.right == cv.right
            t.bottom == cv.bottom
        }
    }
    
    func setProperties(){
        containerView.addSubview(musclePicker)
        muscleName.text = allMuscleTypes[0].rawValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let exerciseViewController = segue.destination as? ExerciseViewController{
            if let selectedExerciseIndex = tableOfExercises.indexPathForSelectedRow?.row{
                exerciseViewController.currentExercise = currentMuscleExercises[selectedExerciseIndex]
            }
        }
    }
    
    func filter(_ array: [Exercise], by muscle: MuscleType) -> [Exercise] {
        return array.filter({ $0.muscleType?.contains(muscle) ?? false })
    }
}

extension ExercisesViewController: AKPickerViewDelegate, AKPickerViewDataSource {
    
    func numberOfItems(in pickerView: AKPickerView!) -> UInt {
        return UInt(allMuscleTypes.count)
    }
    
    func pickerView(_ pickerView: AKPickerView!, didSelectItem item: Int) {
        let currentMuscle = allMuscleTypes[item]
        currentMuscleExercises = filter(allExercises, by: currentMuscle)
        muscleName.text = currentMuscle.rawValue
    }
    
    func pickerView(_ pickerView: AKPickerView!, imageForItem item: Int) -> UIImage! {
        let currentMuscle = allMuscleTypes[item].image()
        let heightOfImage = CGFloat(74)
        return UIImage.resizeImage(image: currentMuscle, targetSize: CGSize(width: heightOfImage * 1.5, height: heightOfImage))
    }
    
    func pickerView(_ pickerView: AKPickerView!, marginForItem item: Int) -> CGSize {
        return CGSize(width: 74, height: 74)
    }
    
}

extension ExercisesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMuscleExercises.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else { return UITableViewCell() }
        let exercise = currentMuscleExercises[indexPath.row]
        exerciseCell.setIntoCell(exercise)
        return exerciseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfCell
    }
}

