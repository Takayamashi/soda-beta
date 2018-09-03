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
    
    var selectedGoodButton: UILabel!
    
    
    var cachedHeight = [IndexPath : CGFloat]()
    
    // ボタン作成
    var searchButton: UIBarButtonItem?
    var noteButton: UIBarButtonItem?
    var noteexistButton: UIBarButtonItem?
    
    var goodcount = [Int]()
    var checkarray = [Bool]()
    var checknote: Bool!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.invalidateIntrinsicContentSize()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checknote = true
        
        goodcount = [1 ,2, 3, 4, 4, 9, 99, 100, 101, 9]
        checkarray = [false, false,false,false,false,false,false,false,false,false]
        
        searchButton = UIBarButtonItem(image: UIImage(named: "search20")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickSearchButton))
        
        noteButton = UIBarButtonItem(image: UIImage(named: "notification")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickNoteButton))
        
        noteexistButton = UIBarButtonItem(image: UIImage(named: "notification_exist")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickNoteButton))
        
        
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
    
    @IBAction func GoodButtonTapp(_ sender: UIButton) {
        let row = sender.tag
        let indexPath = IndexPath(row: row, section: 0)
        
        if checkarray[row] == false{
            checkarray[row] = true
            goodcount[row] += 1
        }else{
            checkarray[row] = false
            goodcount[row] -= 1
        }
        
        print(row)
        
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        
        //let cell = tableView.cellForRow(at: indexPath) as! HomeCell
        
        // Images
        /*
        let checkedImage = UIImage(named: "goodchecked")! as UIImage
        let uncheckedImage = UIImage(named: "goodbutton")! as UIImage
        
        // Bool property
        if cell.isChecked == false {
            cell.GoodButton.setImage(checkedImage, for: UIControlState.normal)
            cell.GoodCount.text = String(Int(cell.GoodCount.text!)! + 1)
            cell.isChecked = true
        } else {
            cell.GoodButton.setImage(uncheckedImage, for: UIControlState.normal)
            cell.GoodCount.text = String(Int(cell.GoodCount.text!)! - 1)
            cell.isChecked = false
        }
         */
        
        }
    

    
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
        if checknote{
            self.navigationItem.setRightBarButtonItems([noteexistButton!, searchButton!], animated: true)
            
        }else{
            self.navigationItem.setRightBarButtonItems([noteButton!, searchButton!], animated: true)
        }
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutIfNeeded()
        
        cell.GoodCount.text = String(goodcount[indexPath.row])
        cell.GoodButton.tag = indexPath.row
        cell.isChecked = checkarray[indexPath.row]
        
        let checkedImage = UIImage(named: "goodchecked")! as UIImage
        let uncheckedImage = UIImage(named: "goodbutton")! as UIImage
        
        if cell.isChecked == true {
            cell.GoodButton.setImage(checkedImage, for: UIControlState.normal)
        } else {
            cell.GoodButton.setImage(uncheckedImage, for: UIControlState.normal)
        }

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //appdelegateよりwindowサイズを抜き出すため呼び出し
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //EventDetailのstoryboard指定
        let EventDetailstoryboard: UIStoryboard = UIStoryboard(name: "EventDetail", bundle: nil)
        
        //各サイズごとのviewを指定
        let EventDetailView375 = EventDetailstoryboard.instantiateViewController(withIdentifier: "EventDetail375") as! EventDetailViewController
        let EventDetailView320 = EventDetailstoryboard.instantiateViewController(withIdentifier: "EventDetail320") as! EventDetailViewController
        let EventDetailView414 = EventDetailstoryboard.instantiateViewController(withIdentifier: "EventDetail414") as! EventDetailViewController
        
        if appDelegate.display?.width == 320{
            self.show(EventDetailView320, sender: nil)
            
        }else if appDelegate.display?.width == 375{
            self.show(EventDetailView375, sender: nil)
            
        }else if appDelegate.display?.width == 414{
            self.show(EventDetailView414, sender: nil)
            
        }
        
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
        //noteButtonを押した際の処理を記述
        let Searchstoryboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let SearchView = Searchstoryboard.instantiateViewController(withIdentifier: "Search") as! SearchTableViewController
        self.show(SearchView, sender: nil)
    }
    
    @objc func clickNoteButton(){
        //noteButtonを押した際の処理を記述
        let Notificationstoryboard: UIStoryboard = UIStoryboard(name: "Notification", bundle: nil)
        let NotificationView = Notificationstoryboard.instantiateViewController(withIdentifier: "Notification") as! NotificationViewController
        self.show(NotificationView, sender: nil)
        checknote = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
