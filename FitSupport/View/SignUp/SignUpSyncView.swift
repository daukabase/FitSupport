//
//  SignUpSyncVC.swift
//  FitSupport
//
//  Created by Daulet on 07.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
class SignUpSyncView: UIView, CheckIfDataisFilled {
    func allDataIsFilled() -> Bool {
        if let name = nameTextField.text, let email = emailTextField.text,
            name != "" && email != ""{
            if email.isValidEmail() {()
                return true
            }else{
                //alert
            }
        }
        return false
    }
    
    weak var delegateOfSyncView: SignUpDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var content: UILabel!
    
    @IBAction func textFieldExndEditing(){
        if allDataIsFilled() {
            delegateOfSyncView?.enableNextButton()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
        setContent()
        setTextField()
    }
    func setTextField(){
        nameTextField.clearsOnBeginEditing = false
        emailTextField.clearsOnBeginEditing = false
    }
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditingOfTextField(_:)))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    func setContent(){
        switch UIScreen.main.bounds.height {
        case 568:
            content.font = UIFont(name: "OpenSans-Light", size: 14)
        default:
            break
        }
    }
    func setLayer() {
        nameTextField.applyProjectsTextField()
        nameTextField.applySketchShadow()
        nameTextField.setValue(GlobalColors.lightyBlue.color(), forKeyPath: "_placeholderLabel.textColor")
        
        emailTextField.applyProjectsTextField()
        emailTextField.applySketchShadow()
        emailTextField.setValue(GlobalColors.lightyBlue.color(), forKeyPath: "_placeholderLabel.textColor")
    }
    
    @objc func endEditingOfTextField(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
}
extension UITextField{
    func applyProjectsTextField(){
        layer.borderColor = GlobalColors.lightyBlue.color().cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 16
        textColor = GlobalColors.lightyBlue.color()
        font = UIFont(name: "OpenSans-Bold", size: 18)
        self.setRightPaddingPoints(8)
        self.setLeftPaddingPoints(16)
        textAlignment = .left
        backgroundColor = UIColor.white
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension String{
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

