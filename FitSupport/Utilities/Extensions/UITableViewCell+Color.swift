//
//  UITableViewCell+Color.swift
//  FitSupport
//
//  Created by Daulet on 17/02/2019.
//  Copyright © 2019 Daulet. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func set(color: UIColor) {
        textLabel?.font = UIFont(.bold, withSize: 16)
        textLabel?.textColor = color
        detailTextLabel?.font = UIFont(.bold, withSize: 16)
        detailTextLabel?.textColor = color
    }
    
}
