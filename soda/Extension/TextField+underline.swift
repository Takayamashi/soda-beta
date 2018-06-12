//
//  TextField+underline.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/09.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

extension UITextField {
    func addUnderline(width: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
