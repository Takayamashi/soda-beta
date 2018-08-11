//
//  ResponsivelineChange.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/08/11.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class TextViewLine: UITextView {
    
    override func awakeFromNib() {
        
        // 枠のカラー
        self.layer.borderColor = UIColor.gray.cgColor
        
        // 枠の幅
        self.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
    }
}
