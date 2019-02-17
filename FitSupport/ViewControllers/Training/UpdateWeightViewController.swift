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
class UpdateWeightViewController: UIViewController, UIGestureRecognizerDelegate, Customizable {
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.tintColor = UIColor.lightyBlue
        picker.selectRow(User.getIndexOf(kilos: weightOfUser), inComponent: 0, animated: true)
        picker.selectRow(User.getIndexOf(gramms: weightOfUser), inComponent: 1, animated: true)
        return picker
    }()
    
    weak var updateDelegate: UpdateWeightDelegate?
    
    private var currentSelectedWeightKilo: Double?
    private var currentSelectedWeightGramm: Double?
    private var weightOfUser: Double = (currentUser?.currentWeight) ?? 0
    private let defaultWeightIndex = 45
    private let defaultHeightIndex = 85
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.addSubview(pickerView)
        commonInit()
        setupConstraints()
        setupDismissModal()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateDelegate?.updateWeight()
    }
    
    internal func commonInit() {
        pickerView.tintColor = UIColor.lightyBlue
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        setupUpdateButton()
        setupContainerView()
    }
    
    func setupConstraints() {
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
    
    func setupDismissModal() {
        let hidetap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:)))
        hidetap.delegate = self
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(hidetap)
    }
    
    @IBAction func updateWeightButtonPressed() {
        currentUser?.updateCurrent(weightOfUser)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func viewTapped(_ handler: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupUpdateButton() {
        updateButton.layer.cornerRadius = 16
        updateButton.applySketchShadow()
        updateButton.layer.masksToBounds = true
        updateButton.backgroundColor = UIColor.lightyBlue
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = UIColor.lightyBlue.cgColor
        containerView.layer.borderWidth = 0.5
    }
    
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
        if component == 0 {
            currentSelectedWeightKilo = Double(allWeightsKilosAvailable[row])
        } else {
            currentSelectedWeightGramm = Double(alLWeightsGrammsAvailable[row])/1000
        }
        weightOfUser = (currentSelectedWeightKilo ?? Double(allWeightsKilosAvailable[defaultWeightIndex])) + (currentSelectedWeightGramm ?? 0)
    }
}
