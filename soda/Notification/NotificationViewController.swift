//
//  NotificationViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/10.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.applicationIconBadgeNumber = 0

        setnavigationBar()
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        //ナビゲーションアイテムのタイトルに画像を設定する
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"logo_white_small"))
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
