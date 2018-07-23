//
//  HomeViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/29.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class HomeViewController: UIViewController,UITabBarDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet var wholeView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    //responsive
    var resizedView: CGSize?
    
    
    
    var cachedHeight = [IndexPath : CGFloat]()
    
    
    // ボタン作成
    var searchButton: UIBarButtonItem?
    var noteButton: UIBarButtonItem?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.invalidateIntrinsicContentSize()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton = UIBarButtonItem(image: UIImage(named: "search20")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickSearchButton))
        
        noteButton = UIBarButtonItem(image: UIImage(named: "notification20")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickNoteButton))
        
        
        UITabBar.appearance().tintColor = UIColor(red: 63.0/255.0, green: 128.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.setnavigationBar()
        
        //tableView.rowHeight = UITableViewAutomaticDimension //追加
        //tableView.estimatedRowHeight = 270 //追加
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 270
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //次の画面に戻るボタン設置
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem

    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension //変更
    }
    */
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //self.slideMenuController()?.openLeftWithVelocity(1.0)
        //self.slideMenuController()?.closeLeftWithVelocity(1.0)
        self.slideMenuController()?.addLeftGestures()
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        //バーの左側にボタンを配置(ライブラリ特有)
        addLeftBarButtonWithImage(UIImage(named: "list20")!)
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.setRightBarButtonItems([noteButton!, searchButton!], animated: true)
        
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"logo_white_small"))
    
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    //tableviewのデリゲートメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutIfNeeded()
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let EventDetailstoryboard: UIStoryboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let EventDetailView = EventDetailstoryboard.instantiateViewController(withIdentifier: "EventDetail") as! EventDetailViewController
        EventDetailView.resultHandler = "text"
        self.show(EventDetailView, sender: nil)
        
        //performSegue(withIdentifier: "EventDetail", sender: nil)
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
    
    @objc func clickSearchButton(){
        //searchButtonを押した際の処理を記述
        //let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
        //self.present(loginViewController!, animated: true, completion: nil)
    }
    
    @objc func clickNoteButton(){
        //noteButtonを押した際の処理を記述
        let Notificationstoryboard: UIStoryboard = UIStoryboard(name: "Notification", bundle: nil)
        let NotificationView = Notificationstoryboard.instantiateViewController(withIdentifier: "Notification") as! NotificationViewController
        self.show(NotificationView, sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
