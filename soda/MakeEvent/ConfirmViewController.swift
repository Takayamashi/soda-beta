//
//  ConfirmViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/26.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    /*
     let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickbackButton))
     */
    
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        
        //ナビゲーションバーの右側にボタン付与
        // self.navigationItem.setLeftBarButtonItems([backButton], animated: true)
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        //ナビゲーションアイテムのタイトル
        self.navigationItem.title = "イベントの確認"
    }
    
    @objc func clickbackButton(){
        //トップ画面に戻る
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
