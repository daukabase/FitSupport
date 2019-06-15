//
//  SignUpPersonalDetails.swift
//  FitSupport
//
//  Created by Daulet on 07.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

enum PickerDataFor {
    case weight, height
    
    func components() -> Int {
        switch self {
        case .weight:
            return 2
        case .height:
            return 1
        }
    }
    
    func getData() -> [[Int]] {
        switch self {
        case .weight:
            return [Constants.allWeightsKilosAvailable, Constants.allWeightsGrammsAvailable]
        case .height:
            return [Constants.allHeihgtsAvailable]
        }
    }
}

class SignUpPersonalDetails: UIView, CheckIfDataisFilled {
    
    weak var delegatePersonDetails: SignUpDelegate?
    
    var birthdayOfUser: Date = Date()
    var weightOfUser: Double?
    var heightOfUser: Int?
    
    private var _dateIsChoosen = false
    private var currentSelectedWeightKilo: Double?
    private var currentSelectedWeightGramm: Double?
    private var currentPickerData: PickerDataFor?
    private var defaultDate: Date = Date.from(year: 1998, month: 12, day: 30)
    private var minDate: Date? = Date.from(year: 1939, month: 1, day: 1)
    private var maxDate: Date? = Calendar.current.date(byAdding: .year, value: -12, to: Date())
    private let defaultWeightIndex = 45
    private let defaultHeightIndex = 85
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var stackOfInputDetails: UIStackView!
    @IBOutlet weak var dateSubstackOfInputDetails: UIStackView!
    @IBOutlet weak var weightSubstackOfInputDetails: UIStackView!
    @IBOutlet weak var heightSubstackOfInputDetails: UIStackView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    lazy var picker: UIPickerView = {
        let weight = UIPickerView()
        weight.delegate = self
        weight.dataSource = self
        if let currentPickerData = currentPickerData{
            switch currentPickerData{
            case .weight:
                weight.selectRow(45, inComponent: 0, animated: false)
            case .height:
                weight.selectRow(150, inComponent: 0, animated: false)
            }
        }
        return weight
    }()
    
    lazy var datePicker: UIDatePicker = {
        let date = UIDatePicker()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYY"
        date.minimumDate = minDate
        date.maximumDate = maxDate
        date.date = defaultDate
        date.datePickerMode = .date
        // TODO: localize
        date.locale = Locale(identifier: "ru_RU")
        return date
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createAreaForCityPicker()
        setLayer()
        setDefaultValue()
        setContent()
    }
    
    func setContent() {
        switch UIScreen.main.bounds.height {
        case 568:
            content.font = UIFont(.displayLight, withSize: 16)
            stackOfInputDetails.spacing = 12
            dateSubstackOfInputDetails.spacing = 12
            weightSubstackOfInputDetails.spacing = 12
            heightSubstackOfInputDetails.spacing = 12
        default:
            constraint.constant = 32
        }
    }
    
    func setDefaultValue() {
        dateTextField.placeholder = defaultDate.toString()
        // TODO: localize
        weightTextField.placeholder = "\(Constants.allWeightsKilosAvailable[defaultWeightIndex]) кг"
        heightTextField.placeholder = "\(Constants.allHeihgtsAvailable[defaultHeightIndex]) см"
    }
    
    func allDataIsFilled() -> Bool {
        let textFields = [dateTextField, weightTextField, heightTextField]
        return textFields.filter { (tf) -> Bool in
            return tf?.text != nil && tf?.text != ""
        }.count == textFields.count
    }
    
    func createAreaForCityPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hidePicker))
        toolbar.setItems([flexible, doneButton], animated: true)
        weightTextField.inputAccessoryView = toolbar
        weightTextField.inputView = picker
        heightTextField.inputAccessoryView = toolbar
        heightTextField.inputView = picker
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    func setNextButton() {
        if allDataIsFilled() {
            delegatePersonDetails?.enableNextButton()
        }
    }
    
    func hasDataAfterPoint(number: Double) -> Bool{
        return Double(Int(number)) != number
    }
    
    func setLayer() {
        dateTextField.setPersonaDetailsTextField()
        weightTextField.setPersonaDetailsTextField()
        heightTextField.setPersonaDetailsTextField()
    }
    
    @IBAction func setWeightData(sender: UITextField) {
        currentPickerData = PickerDataFor.weight
        _dateIsChoosen = false
        picker.reloadAllComponents()
        picker.selectRow(defaultWeightIndex, inComponent: 0, animated: false)
    }
    
    @IBAction func setHeightData(sender: UITextField) {
        currentPickerData = PickerDataFor.height
        _dateIsChoosen = false
        picker.reloadAllComponents()
        picker.selectRow(defaultHeightIndex, inComponent: 0, animated: false)
    }
    
    @IBAction func setDateData(sender: UITextField) {
        _dateIsChoosen = true
    }
    
    @objc func hidePicker() {
        if _dateIsChoosen {
            let dateString = datePicker.date.toString()
            self.birthdayOfUser = datePicker.date
            dateTextField.text = dateString
        } else {
            // TODO: lcoalize
            guard let picker = currentPickerData else { return }
            switch picker {
            case .weight:
                self.weightOfUser = (currentSelectedWeightKilo ?? Double(Constants.allWeightsKilosAvailable[defaultWeightIndex])) + (currentSelectedWeightGramm ?? 0)
                weightTextField.text = "\(weightOfUser!) кг"
            case .height:
                heightTextField.text = "\(heightOfUser ?? Constants.allHeihgtsAvailable[defaultHeightIndex]) cм"
            }
        }
        endEditing(true)
        setNextButton()
    }
    
}

extension SignUpPersonalDetails: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let data = currentPickerData else{
            return 0
        }
        return data.components()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = currentPickerData else {
            return 0
        }
        switch data {
        case .weight:
            if component == 0 {
                return data.getData()[0].count
            } else {
                return data.getData()[1].count
            }
        case .height:
            return data.getData()[0].count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = currentPickerData else {
            return ""
        }
        // TODO: localize
        switch data {
        case .height:
            return "\(data.getData()[0][row]) cм"
        case .weight:
            if component == 0{
                return "\(data.getData()[0][row]) кг"
            }
            return ".\(data.getData()[1][row]) г"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = currentPickerData else { return }
        switch data {
        case .height:
            heightOfUser = data.getData()[0][row]
        case .weight:
            if component == 0{
                currentSelectedWeightKilo = Double(Constants.allWeightsKilosAvailable[row])
            } else {
                currentSelectedWeightGramm = Double(Constants.allWeightsGrammsAvailable[row]) / 1000
            }
        }
    }
}
