//
//  UserInfoViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
protocol UserInfoDelegate: AnyObject {
    func update(cuurent user:User)
}
class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var weightGraph: WeighGraphView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var updateWeightTextField: UITextField!
    
    private var currentSelectedWeightKilo: Double?
    private var currentSelectedWeightGramm: Double?
    
    var currentUser: User?{
        didSet{
            if currentUser != nil{
                userInfoDelegate?.update(cuurent: currentUser!)
            }
        }
    }
    
    weak var userInfoDelegate: UserInfoDelegate?
    
    func setUserInformation(){
        guard let currentUser = currentUser else {
            return
        }
        avatar.image = #imageLiteral(resourceName: "AVA")
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.layer.borderColor = GlobalColors.darkBlue.color().cgColor
        avatar.layer.borderWidth = 0.5
        name.text = currentUser.name
        age.text = "\(currentUser.Age ?? 0) лет"
        weight.text = "\(Int(currentUser.currentWeight ?? 0)) кг"
        height.text = "\(Int(currentUser.height)) см"
        navigationItem.title = currentUser.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayer()
        pickerView.delegate = self
        pickerView.dataSource = self
        weightGraph.layer.cornerRadius = 16
        if let currentUser = currentUser{
            weightGraph.weights = currentUser.UpdatedWeights
        }
        createAreaForCityPicker()
    }
    override func viewDidAppear(_ animated: Bool) {
        setShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserInformation()
    }
    
    func setLayer(){
        containerView.layer.cornerRadius = 16
        logoutButton.layer.cornerRadius = 16
    }
    func setShadow(){
        logoutButton.applySketchShadow()
        containerView.applySketchShadow()
    }
    
    lazy var pickerView: UIPickerView = {
        let city = UIPickerView()
        return city
    }()
    
    func createAreaForCityPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideAgePicker))
        toolbar.setItems([doneButton], animated: true)
        updateWeightTextField.inputAccessoryView = toolbar
        updateWeightTextField.inputView = pickerView
    }
    
    @objc func hideAgePicker(){
        let weight = (currentSelectedWeightKilo ?? 0) + (currentSelectedWeightGramm ?? 0)
        currentUser?.updateCurrent(weight)
        updateWeightTextField.text = ""
        view.endEditing(true)
    }
    @IBAction func logoutButtonPressed(){
        showAlert(with: .confirmation, title: "Вы уверены что хотите выйти", message: "После выхода из системы ваши данные будут утрачены") { [weak self] in
            self?.currentUser?.deleteFromRealm()
            self?.currentUser = nil
            self?.performSegue(withIdentifier: "signUp", sender: nil)
        }
    }
}
extension UserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
        switch component {
        case 0:
            currentSelectedWeightKilo = Double(allWeightsKilosAvailable[row])
        case 1:
            currentSelectedWeightGramm = Double(alLWeightsGrammsAvailable[row])/1000
        default:
            break
        }
        
    }
}
