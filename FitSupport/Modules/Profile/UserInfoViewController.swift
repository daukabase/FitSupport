//
//  UserInfoViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

protocol UserInfoDelegate: AnyObject {
    func update(current user: User)
}

class UserInfoViewController: UIViewController, Customizable {
    
    var currentUser: User? {
        didSet {
            if let currentUser = currentUser {
                delegate?.update(current: currentUser)
            }
        }
    }
    
    weak var delegate: UserInfoDelegate?
    
    private var currentSelectedWeightKilo: Double?
    private var currentSelectedWeightGramm: Double?
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        let weight = currentUser?.currentWeight ?? 0.0
        pickerView.selectRow(User.getIndexOf(kilos: weight), inComponent: 0, animated: true)
        pickerView.selectRow(User.getIndexOf(gramms: weight), inComponent: 1, animated: true)
        return pickerView
    }()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var weightGraph: WeighGraphView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var updateWeightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        createAreaForCityPicker()
        setupUserData()
    }
    
    func setupUserData() {
        if let currentUser = currentUser {
            weightGraph.weights = currentUser.weights
        }
    }
    
    func setUserInformation() {
        guard let currentUser = currentUser else { return }
        
        // TODO: localize
        
        name.text = currentUser.name
        age.text = "\(currentUser.age ?? 0) лет"
        weight.text = "\(Int(currentUser.currentWeight ?? 0)) кг"
        height.text = "\(Int(currentUser.height)) см"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserInformation()
    }
    
    @objc func hideAgePicker() {
        let weight = (currentSelectedWeightKilo ?? 0) + (currentSelectedWeightGramm ?? 0)
        currentUser?.updateCurrent(weight)
        updateWeightTextField.text = ""
        view.endEditing(true)
    }
    
    @IBAction func logoutButtonPressed() {
        // TODO: localize
        showAlert(with: .confirmation, title: "Вы уверены что хотите выйти", message: "После выхода из системы ваши данные будут утрачены") { [weak self] in
            self?.currentUser?.deleteFromRealm()
            self?.currentUser = nil
            self?.performSegue(withIdentifier: "signUp", sender: nil)
        }
    }
    
    private func commonInit() {
        navigationItem.title = currentUser?.name
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        weightGraph.layer.cornerRadius = 16
        containerView.layer.cornerRadius = 16
        logoutButton.layer.cornerRadius = 16
        
        avatar.image = #imageLiteral(resourceName: "AVA")
        avatar.layer.cornerRadius = avatar.frame.height / 2
        avatar.layer.borderColor = UIColor.darkBlue.cgColor
        avatar.layer.borderWidth = 0.5
    }
    
    private func createAreaForCityPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideAgePicker))
        toolbar.setItems([doneButton], animated: true)
        updateWeightTextField.inputAccessoryView = toolbar
        updateWeightTextField.inputView = pickerView
    }
    
    private func setupShadow() {
        logoutButton.applySketchShadow()
        containerView.applySketchShadow()
    }
    
}

extension UserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        // TODO: localize
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
        switch component {
        case 0:
            currentSelectedWeightKilo = Double(Constants.allWeightsKilosAvailable[row])
        case 1:
            currentSelectedWeightGramm = Double(Constants.allWeightsGrammsAvailable[row])/1000
        default:
            break
        }
    }
    
}
