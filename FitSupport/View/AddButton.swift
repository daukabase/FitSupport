//
//  AddButton.swift
//  FitSupport
//
//  Created by Daulet on 31.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class AddButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        exercise(isClicked)
    }
    var isClicked = false
    func swapImage(){
        isClicked = !isClicked
        setImage(for: isClicked)
    }
    func exercise(_ isSelected: Bool){
        isClicked = isSelected
        setImage(for: isSelected)
    }
    func setImage(for condition: Bool) {
        if condition{
            self.setImage(#imageLiteral(resourceName: "doneForStoryCard"), for: UIControlState.normal)
        }else{
            self.setImage(#imageLiteral(resourceName: "add"), for: UIControlState.normal)
        }
    }
}
