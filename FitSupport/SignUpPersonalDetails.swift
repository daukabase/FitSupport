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
            return [allWeightsKilosAvailable, alLWeightsGrammsAvailable]
        case .height:
            return [allHeihgtsAvailable]
        }
    }
}
class SignUpPersonalDetails: UIView, CheckIfDataisFilled {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createAreaForCityPicker()
        setLayer()
    }
    
    weak var delegatePersonDetails: SignUpDelegate?
    
    func allDataIsFilled() -> Bool {
        if dateTextField.text != "" && weightTextField.text != "" && heightTextField.text != ""{
            if dateTextField.text != nil && weightTextField.text != nil && heightTextField.text != nil {
                return true
            }
        }
        return false
    }
    
    
    var weightOfUser: Double?
    var heightOfUser: Int?
    
    private var currentSelectedWeightKilo: Double?
    private var currentSelectedWeightGramm: Double?
    private var currentPickerData: PickerDataFor?
    
    func createAreaForCityPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hidePicker))
        toolbar.setItems([doneButton], animated: true)
        weightTextField.inputAccessoryView = toolbar
        weightTextField.inputView = weightPicker
        heightTextField.inputAccessoryView = toolbar
        heightTextField.inputView = weightPicker
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    @IBAction func setWeightData(sender: UITextField) {
        currentPickerData = PickerDataFor.weight
        _dateIsChoosen = false
        weightPicker.reloadAllComponents()
        weightPicker.selectRow(45, inComponent: 0, animated: false)
    }
    @IBAction func setHeightData(sender: UITextField) {
        currentPickerData = PickerDataFor.height
        _dateIsChoosen = false
        weightPicker.reloadAllComponents()
        weightPicker.selectRow(150, inComponent: 0, animated: false)
    }
    @IBAction func setDateData(sender: UITextField) {
        _dateIsChoosen = true
    }
    private var _dateIsChoosen = false
    
    @objc func hidePicker(){
        if _dateIsChoosen {
            let dateString = datePicker.date.toString(dateFormat: "dd MM YYYY")
            dateTextField.text = dateString
        }
        else{
            guard let picker = currentPickerData else { return }
            switch picker {
            case .weight:
                self.weightOfUser = (currentSelectedWeightKilo ?? 0) + (currentSelectedWeightGramm ?? 0)
                weightTextField.text = "\(weightOfUser!) кг"
            case .height:
                heightTextField.text = "\(heightOfUser ?? 120) cм"
            }
        }
        self.endEditing(true)
        setNextButton()
    }
    func setNextButton(){
        if allDataIsFilled() {
            delegatePersonDetails?.enableNextButton()
        }
    }
    
    func hasDataAfterPoint(number: Double) -> Bool{
        return Double(Int(number)) != number
    }
    
    func setLayer(){
        dateTextField.setPersonaDetailsTextField()
        weightTextField.setPersonaDetailsTextField()
        heightTextField.setPersonaDetailsTextField()
    }
    
    lazy var weightPicker: UIPickerView = {
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
        date.date = Date.from(year: 1998, month: 12, day: 30)
        date.datePickerMode = .date
        date.locale = Locale(identifier: "ru_RU")
        return date
    }()
    
}
extension UITextField{
    func setPersonaDetailsTextField(){
        textAlignment = .right
        textColor = GlobalColors.lightyBlue.color()
        font = UIFont(name: "OpenSans-Regular", size: 16)
    }
}
extension SignUpPersonalDetails: UIPickerViewDelegate, UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let data = currentPickerData else{
            return 0
        }
        return data.components()
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = currentPickerData else{
            return 0
        }
        switch data {
        case .weight:
            if component == 0{
                return data.getData()[0].count
            }else{
                return data.getData()[1].count
            }
        case .height:
            return data.getData()[0].count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = currentPickerData else{
            return ""
        }
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
        guard let data = currentPickerData else{
            return
        }
        switch data {
        case .height:
            heightOfUser = data.getData()[0][row]
        case .weight:
            if component == 0{
                currentSelectedWeightKilo = Double(allWeightsKilosAvailable[row])
            }else{
                currentSelectedWeightGramm = Double(alLWeightsGrammsAvailable[row])/1000
            }
        }
    }
}
extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
