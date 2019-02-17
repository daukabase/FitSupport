//
//  UITextField.swift
//  FitSupport
//
//  Created by Daulet on 19/11/2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func applyProjectsTextField(){
        layer.borderColor = UIColor.lightyBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 16
        textColor = UIColor.lightyBlue
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
