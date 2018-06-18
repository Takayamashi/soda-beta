//
//  MadeEventViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/12.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class MadeEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectNumber:Int = 0 //タップしたalertControllerの位置を記録する変数
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var myLeftButton: UIBarButtonItem!
    
    var mainViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let mainController = storyboard?.instantiateViewController(withIdentifier: "Main") as! HomeViewController
        self.mainViewController = UINavigationController(rootViewController: mainController)
        
        // 左ボタンを作成する.
        myLeftButton = UIBarButtonItem(image:UIImage(named: "back"), style: .plain, target: self, action: #selector(clickbackButton(sender:)))
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.leftBarButtonItem = myLeftButton
        setnavigationBar()

    }
    
    //tableviewのデリゲートメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MadeCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }

    @IBAction func SettingEvent(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "", message: "", preferredStyle:  UIAlertControllerStyle.actionSheet)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "イベントの内容を変更", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "settingevent", sender: nil)
            
        })
        let defaultAction1: UIAlertAction = UIAlertAction(title: "イベントを取り消す", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            self.selectNumber = 1
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        defaultAction.setValue(UIImage(named: "made2.png"), forKey: "image")
        defaultAction.setValue(UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1), forKey: "imageTintColor")
        
        defaultAction1.setValue(UIImage(named: "cancel.png"), forKey: "image")
        defaultAction1.setValue(UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1), forKey: "imageTintColor")
        
        cancelAction.setValue(UIImage(named: "cross.png"), forKey: "image")
        cancelAction.setValue(UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1), forKey: "imageTintColor")
        
        alert.addAction(defaultAction)
        alert.addAction(defaultAction1)
        alert.addAction(cancelAction)
        //下記のtintColorをいじるとalertControllerのボタン部分が全て色変更される。
        alert.view.tintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 0.8)
        present(alert, animated: true, completion: nil)
        
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        //次の画面に戻るボタン設置
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.title = "作成したイベント"
        
    }
    
    @objc func clickbackButton(sender: UIButton){
        //もともとのアニメーションを削除
        self.view.layer.removeAllAnimations()
        let transition = CATransition()
        transition.duration = 10
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
