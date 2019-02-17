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
        self.textLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
        self.textLabel?.textColor = color
        self.detailTextLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
        self.detailTextLabel?.textColor = color
    }
}
