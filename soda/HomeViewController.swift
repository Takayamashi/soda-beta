//
//  HomeViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/29.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor(red: 63.0/255.0, green: 128.0/255.0, blue: 255.0/255.0, alpha: 1)

    }
    
/* tabBarの実装
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            //home画面に更新
     
     
        case 2:
            //人気画面に更新
     
            
        case: 3
            //行きたい画面に遷移
            
            
            
        case: 4
            //作成画面に遷移
            
            
        default:
            return
        }

    }
*/
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
