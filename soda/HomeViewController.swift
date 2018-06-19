//
//  HomeViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/29.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class HomeViewController: UIViewController,UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // ボタン作成
    let searchButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "search20")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))
    let noteButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "notification20")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor(red: 63.0/255.0, green: 128.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        self.setnavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //次の画面に戻るボタン設置
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem

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
    
    
    //tableviewのデリゲートメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    // Storyboardで遷移時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 遷移先のコントローラを取得
        let controller = segue.destination as! EventDetailViewController
        
        // 遷移先で処理を終えた後の処理をここで書く
        controller.resultHandler = "test" // テスト
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "EventDetail") as! EventDetailViewController
        nextView.resultHandler = "text"
        self.show(nextView, sender: nil)
        
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
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
