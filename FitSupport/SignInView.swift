//
//  SignInView.swift
//  FitSupport
//
//  Created by Daulet on 07.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class SignInView: UIView {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
        setLayer()
    }

    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditingOfTextField(_:)))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    func setLayer() {
        passwordTextField.applyProjectsTextField()
        passwordTextField.applySketchShadow()
        passwordTextField.setValue(GlobalColors.lightyBlue.color(), forKeyPath: "_placeholderLabel.textColor")
        
        emailTextField.applyProjectsTextField()
        emailTextField.applySketchShadow()
        emailTextField.setValue(GlobalColors.lightyBlue.color(), forKeyPath: "_placeholderLabel.textColor")
    }
    
    @objc func endEditingOfTextField(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
}
