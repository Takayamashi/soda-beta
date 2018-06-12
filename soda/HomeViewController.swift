//
//  HomeViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/29.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class HomeViewController: UIViewController,UITabBarDelegate {
    @IBOutlet weak var Menu: UIButton!
    
    // ボタン作成
    let searchButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))
    let noteButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "note")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor(red: 63.0/255.0, green: 128.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        self.setnavigationBar()

    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        //バーの左側にボタンを配置(ライブラリ特有)
        addLeftBarButtonWithImage(UIImage(named: "list")!)
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.setRightBarButtonItems([noteButton, searchButton], animated: true)
        
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"logo_white_small"))
    
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    @objc func clickSearchButton(){
        //searchButtonを押した際の処理を記述
    }
    
    @objc func clickRefreshButton(){
        //refreshButtonを押した際の処理を記述
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
