//
//  EventDetailViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/16.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    var resultHandler: String!
    
    var myLeftButton: UIBarButtonItem!
    var mainViewController: UIViewController!
    let myNavItems = UINavigationItem()
    
    //バーの右側に設置するボタンの作成
    var rightNavBtn: UIBarButtonItem! = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setnavigationBar()
        
        // 左ボタンを作成する.
        rightNavBtn = UIBarButtonItem(image:UIImage(named: "share"), style: .plain, target: self, action: #selector(clickshareButton))
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.rightBarButtonItem = rightNavBtn
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"logo_white_small"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func alertControll(){
        let alert: UIAlertController = UIAlertController(title: "リンクの共有", message: "", preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "twitter", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            
            
        })
        let defaultAction1: UIAlertAction = UIAlertAction(title: "facebook", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            
            
        })
        let defaultAction2: UIAlertAction = UIAlertAction(title: "リンクをコピー", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        defaultAction.setValue((UIImage(named: "twitter_s.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!, forKey: "image")
        
        defaultAction1.setValue((UIImage(named: "facebook_s.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!, forKey: "image")
        
        defaultAction2.setValue(UIImage(named: "clip_s.png"), forKey: "image")
        defaultAction2.setValue(UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1), forKey: "imageTintColor")
        
        cancelAction.setValue(UIImage(named: "cross_s.png"), forKey: "image")
        cancelAction.setValue(UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1), forKey: "imageTintColor")
        
        alert.addAction(defaultAction)
        alert.addAction(defaultAction1)
        alert.addAction(defaultAction2)
        alert.addAction(cancelAction)
        //下記のtintColorをいじるとalertControllerのボタン部分が全て色変更される。
        alert.view.tintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 0.8)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func clickshareButton(_ sender: Any) {
        alertControll()
        print(resultHandler)
    }
    
    @objc func goodButton(_ sender: Any) {
    }

}
