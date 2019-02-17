//
//  UpdateWeightViewController.swift
//  FitSupport
//
//  Created by Daulet on 11.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import Cartography
protocol UpdateWeightDelegate: AnyObject {
    func updateWeight()
}
class UpdateWeightViewController: UIViewController, UIGestureRecognizerDelegate{
    
    private var currentSelectedWeightKilo: Double?
    private var currentSelectedWeightGramm: Double?
    private var weightOfUser: Double = (currentUser?.currentWeight) ?? 0
    private let defaultWeightIndex = 45
    private let defaultHeightIndex = 85
    
    weak var updateDelegate: UpdateWeightDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBAction func updateWeightButtonPressed(){
        currentUser?.updateCurrent(weightOfUser)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.addSubview(pickerView)
        setFrame()
        setLayer()
        dismissModal()
        pickerView.reloadAllComponents()
        let kiloRowIndex = User.getIndexOf(kilos: weightOfUser)
        let grammRowIndex = User.getIndexOf(gramms: weightOfUser)
        pickerView.selectRow(kiloRowIndex, inComponent: 0, animated: true)
        pickerView.selectRow(grammRowIndex, inComponent: 1, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        updateDelegate?.updateWeight()
    }
    func setLayer(){
        updateButton.layer.cornerRadius = 16
        updateButton.applySketchShadow()
        updateButton.layer.masksToBounds = true
        updateButton.backgroundColor = UIColor.lightyBlue
        pickerView.tintColor = UIColor.lightyBlue
        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = UIColor.lightyBlue.cgColor
        containerView.layer.borderWidth = 0.5
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    func dismissModal(){
        let hidetap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:)))
        hidetap.delegate = self
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(hidetap)
    }
    @objc func viewTapped(_ handler: UITapGestureRecognizer? = nil){
        self.dismiss(animated: true, completion: nil)
    }
    func setFrame(){
        constrain(view, containerView, pickerView, updateButton) { v, c, p, b in
            c.height == v.height / 2
            c.width == v.width * 3 / 4
            c.centerX == v.centerX
            c.centerY == v.centerY - 16
            b.bottom == c.bottom - 16
            b.height == 44
            b.left == c.left + 16
            b.right == c.right - 16
            p.top == c.top + 16
            p.right == c.right - 16
            p.left == c.left + 16
            p.bottom == b.top - 16
        }
    }
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
}
extension UpdateWeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return allWeightsKilosAvailable.count
        case 1:
            return alLWeightsGrammsAvailable.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(allWeightsKilosAvailable[row]) кг"
        case 1:
            return ".\(alLWeightsGrammsAvailable[row]) г"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            currentSelectedWeightKilo = Double(allWeightsKilosAvailable[row])
        }else{
            currentSelectedWeightGramm = Double(alLWeightsGrammsAvailable[row])/1000
        }
        weightOfUser = (currentSelectedWeightKilo ?? Double(allWeightsKilosAvailable[defaultWeightIndex])) + (currentSelectedWeightGramm ?? 0)
    }
}
