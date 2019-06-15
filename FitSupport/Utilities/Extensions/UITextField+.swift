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
    
    func applyProjectsTextField() {
        layer.borderColor = UIColor.lightyBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 16
        textColor = UIColor.lightyBlue
        font = UIFont(.bold, withSize: 18)
        setRightPaddingPoints(8)
        setLeftPaddingPoints(16)
        textAlignment = .left
        backgroundColor = UIColor.white
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
