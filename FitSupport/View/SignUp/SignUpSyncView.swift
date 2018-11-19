//
//  SignUpSyncVC.swift
//  FitSupport
//
//  Created by Daulet on 07.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
class SignUpSyncView: UIView, CheckIfDataisFilled {
    
    weak var delegateOfSyncView: SignUpDelegate?
    
    var keyboardFrame: CGFloat {
        return 46
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
        setContent()
        NotificationCenter.default.addObserver(self, selector: #selector(emptyfunc(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var emailTextFieldActualHeight: CGFloat?
    var nameTextFieldActualHeight: CGFloat?
    
    @IBAction func emailTextFieldBeginEditing() {
        if emailTextFieldActualHeight == nil {
            emailTextFieldActualHeight = emailTextField.center.y
        }
        manipulate(textFiled: emailTextField, didBeginEditing: true, textFieldHeight: emailTextFieldActualHeight)
    }
    @IBAction func emailTextFieldEndEditing() {
        manipulate(textFiled: emailTextField, didBeginEditing: false, textFieldHeight: emailTextFieldActualHeight)
    }
    @IBAction func nameTextFieldBeginEditing() {
        if nameTextFieldActualHeight == nil {
            nameTextFieldActualHeight = nameTextField.center.y
        }
        manipulate(textFiled: nameTextField, didBeginEditing: true, textFieldHeight: nameTextFieldActualHeight)
    }
    @IBAction func nameTextFieldEndEditing() {
        manipulate(textFiled: nameTextField, didBeginEditing: false, textFieldHeight: nameTextFieldActualHeight)
    }
    
    @IBAction func textFieldEditingChanged() {
        if allDataIsFilled() {
            delegateOfSyncView?.enableNextButton()
        }
    }
    
    func manipulate(textFiled: UITextField, didBeginEditing: Bool, textFieldHeight: CGFloat?) {
        guard let textFieldHeight = textFieldHeight, let nameTextFieldActualHeight = nameTextFieldActualHeight else { return }
        UIView.animate(withDuration: 0.27) {
            textFiled.center.y = didBeginEditing ? -nameTextFieldActualHeight : textFieldHeight
        }
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
        [nameTextField, emailTextField].forEach { (tf) in
            tf?.applyProjectsTextField()
            tf?.applyProjectsTextField()
            tf?.applySketchShadow()
            tf?.setValue(GlobalColors.lightyBlue.color(), forKeyPath: "_placeholderLabel.textColor")
            tf?.clearsOnBeginEditing = false
        }
    }
    
    func allDataIsFilled() -> Bool {
        if let name = nameTextField.text,
            let email = emailTextField.text,
            name != "" && email != "" && email.isValidEmail(){
            return true
        }
        return false
    }
    
    @objc func endEditingOfTextField(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    @objc func emptyfunc(_ sender: Any) {
        
    }
}
