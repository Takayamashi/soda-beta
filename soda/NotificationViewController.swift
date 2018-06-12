//
//  NotificationViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/10.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickbackButton))

    override func viewDidLoad() {
        super.viewDidLoad()

        setnavigationBar()
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.setLeftBarButtonItems([backButton], animated: true)
        
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.title = "通知"
        
    }
    
    @objc func clickbackButton(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
