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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var muscleName: UILabel!
    @IBOutlet weak var tableOfExercises: UITableView!
    
    let heightOfCell: CGFloat = 76
    
    lazy var musclePicker: AKPickerView = {
        let picker = AKPickerView(frame: view.frame)
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    private var allMuscleTypes: [MuscleType] = [.arm, .chest, .back, .abs, .shoulders, .leg]
    private var currentMuscleExercises: [Exercise] = []{
        didSet{
            tableOfExercises.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setConstraints()
        currentMuscleExercises = Exercises.filtered(by: allMuscleTypes[0])
        tableOfExercises.delegate = self
        tableOfExercises.dataSource = self
    }
    
    func setConstraints() {
        constrain(musclePicker, muscleName, containerView, tableOfExercises) { (m, mn, cv, t) in
            m.top == mn.bottom + 8
            m.left == cv.left
            m.right == cv.right
            m.height == 90
            t.top == m.bottom + 8
            t.left == cv.left
            t.right == cv.right
            t.bottom == cv.bottom
        }
    }
    
    func setProperties(){
        containerView.addSubview(musclePicker)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExerciseInfo"{
            if let exerciseViewController = segue.destination as? ExerciseViewController{
                print(musclePicker.selectedItem)
                print("count\(currentMuscleExercises.count)")
                if let selectedExersiceIndex = tableOfExercises.indexPathForSelectedRow?.row{
                    exerciseViewController.set(currentMuscleExercises[selectedExersiceIndex])
                }
            }
        }
    }

}

extension ExercisesViewController: AKPickerViewDelegate, AKPickerViewDataSource {
    func numberOfItems(in pickerView: AKPickerView!) -> UInt {
        return UInt(allMuscleTypes.count)
    }
    func pickerView(_ pickerView: AKPickerView!, didSelectItem item: Int) {
        let currentMuscle = allMuscleTypes[item]
        currentMuscleExercises = Exercises.filtered(by: currentMuscle)
    }
    func pickerView(_ pickerView: AKPickerView!, imageForItem item: Int) -> UIImage! {
        let currentMuscle = allMuscleTypes[item].image()
        let gradientOfImage = currentMuscle.size.width / currentMuscle.size.height
        let heightOfImage = CGFloat(64)
        return UIImage.resizeImage(image: currentMuscle, targetSize: CGSize(width: heightOfImage * gradientOfImage, height: heightOfImage))
    }
}
extension ExercisesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMuscleExercises.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else{ return UITableViewCell() }
        let exercise = currentMuscleExercises[indexPath.row]
        exerciseCell.setIntoCell(exercise)
        return exerciseCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfCell
    }
}
extension UIImage{
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
