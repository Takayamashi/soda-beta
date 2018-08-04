//
//  GoodUIButtonChecked.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/07/23.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class GoodButtonChecker: UIButton {
    
    // Images
    let checkedImage = UIImage(named: "goodchecked")! as UIImage
    let uncheckedImage = UIImage(named: "goodbutton")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
