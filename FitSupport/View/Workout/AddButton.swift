//
//  AddButton.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class AddButton: UIButton {
    
    var isClicked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exercise(isClicked)
    }
    
    func toogle() {
        isClicked.toggle()
        setImage()
    }
    
    func exercise(_ isSelected: Bool){
        isClicked = isSelected
        setImage()
    }
    
    private func setImage() {
        if isClicked {
            self.setImage(#imageLiteral(resourceName: "doneForStoryCard"), for: UIControlState.normal)
        } else {
            self.setImage(#imageLiteral(resourceName: "add"), for: UIControlState.normal)
        }
    }
}
