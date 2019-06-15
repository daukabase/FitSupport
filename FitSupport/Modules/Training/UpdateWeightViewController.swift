//
//  UpdateWeightViewController.swift
//  FitSupport
//
//  Created by Daulet on 11.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import SnapKit

protocol UpdateWeightDelegate: AnyObject {
    func updateWeight()
}

class UpdateWeightViewController: UIViewController, UIGestureRecognizerDelegate, Customizable {
    
    weak var updateDelegate: UpdateWeightDelegate?
    
    private var currentSelectedWeightKilo: Double?
    private var currentSelectedWeightGramm: Double?
    private var weightOfUser: Double = (currentUser?.currentWeight) ?? 0
    private let defaultWeightIndex = 45
    private let defaultHeightIndex = 85
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.tintColor = UIColor.lightyBlue
        picker.selectRow(User.getIndexOf(kilos: weightOfUser), inComponent: 0, animated: true)
        picker.selectRow(User.getIndexOf(gramms: weightOfUser), inComponent: 1, animated: true)
        return picker
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setupViews()
        setupConstraints()
        setupDismissModal()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateDelegate?.updateWeight()
    }
    
    private func commonInit() {
        pickerView.tintColor = UIColor.lightyBlue
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        setupUpdateButton()
        setupContainerView()
    }
    
    private func setupViews() {
        containerView.addSubview(pickerView)
    }
    
    private func setupConstraints() {
        pickerView.snp.makeConstraints { [unowned self] (make) in
            make.top.equalTo(self.containerView).offset(32)
            make.right.equalTo(self.containerView).offset(-32)
            make.left.equalTo(self.containerView).offset(32)
            make.bottom.equalTo(self.updateButton.snp.top).offset(-32)
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
            return Constants.allWeightsKilosAvailable.count
        case 1:
            return Constants.allWeightsGrammsAvailable.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(Constants.allWeightsKilosAvailable[row]) кг"
        case 1:
            return ".\(Constants.allWeightsGrammsAvailable[row]) г"
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentSelectedWeightKilo = Double(Constants.allWeightsKilosAvailable[row])
        } else {
            currentSelectedWeightGramm = Double(Constants.allWeightsGrammsAvailable[row])/1000
        }
        weightOfUser = (currentSelectedWeightKilo ?? Double(Constants.allWeightsKilosAvailable[defaultWeightIndex])) + (currentSelectedWeightGramm ?? 0)
    }
}
