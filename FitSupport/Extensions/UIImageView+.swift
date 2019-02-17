//
//  UIImageView+.swift
//  FitSupport
//
//  Created by Daulet on 17/02/2019.
//  Copyright © 2019 Daulet. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
