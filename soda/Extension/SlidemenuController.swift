//
//  SlidemenuController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/07/01.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ExSlideMenuController : SlideMenuController {
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is HomeViewController ||
                vc is MakeEventViewController ||
                vc is ProfileConfigViewController ||
                vc is MadeEventViewController {
                return true
            }
        }
        return false
    }
    
    override func awakeFromNib() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "Main")
        let leftVC = storyboard.instantiateViewController(withIdentifier: "Left")
        let rightVC = storyboard.instantiateViewController(withIdentifier: "ProfileConfig")
        
        //NavigationBarを生成
        let navigationController = UINavigationController(rootViewController: mainVC)
        navigationController.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController.navigationBar.tintColor = UIColor.white
        
        //ライブラリ特有のプロパティにセット
        mainViewController = navigationController
        leftViewController = leftVC
        rightViewController = rightVC
        SlideMenuOptions.leftViewWidth = 280
        SlideMenuOptions.rightViewWidth = 375
        super.awakeFromNib()
    }
}
