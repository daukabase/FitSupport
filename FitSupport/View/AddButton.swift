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
        self.setImage(#imageLiteral(resourceName: "add"), for: UIControlState.normal)
    }
    var isClicked = false
    func swapImage(){
        if !isClicked{
            self.setImage(#imageLiteral(resourceName: "doneForStoryCard"), for: UIControlState.normal)
        }else{
            self.setImage(#imageLiteral(resourceName: "add"), for: UIControlState.normal) 
        }
        isClicked = !isClicked
    }

}
