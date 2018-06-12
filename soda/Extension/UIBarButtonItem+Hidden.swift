//
//  UIBarButtonItem+Hidden.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/12.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//
import UIKit

extension UIBarButtonItem {
    enum HiddenItem: Int {
        case Arrow = 100
        case Back = 101
        case Forward = 102
        case Up = 103
        case Down = 104
    }
    
    convenience init(barButtonHiddenItem: HiddenItem, target: AnyObject?, action: Selector?) {
        let systemItem = UIBarButtonSystemItem(rawValue: barButtonHiddenItem.rawValue)
        self.init(barButtonSystemItem: systemItem!, target: target, action: action)
    }
}
