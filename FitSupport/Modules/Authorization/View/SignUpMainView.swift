//
//  SignUpMainView.swift
//  FitSupport
//
//  Created by Daulet on 07.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class SignUpMainView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setContent()
    }
    
    func setContent() {
        // TODO: refactor
        switch UIScreen.main.bounds.height {
        case 568:
            content.font = UIFont(.displayLight, withSize: 16)
        default:
            break
        }
    }
}
