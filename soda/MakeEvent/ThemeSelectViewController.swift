//
//  ViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/09/05.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class ThemeSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var imageArray = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image0 = UIImage(named: "defaulttheme")
        let image1 = UIImage(named: "defaulttheme1")
        
        imageArray = [image0!, image1!]
        
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
    
    
    //tableviewのデリゲートメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let cellimage = cell.viewWithTag(1) as! UIImageView
        
        cellimage.image = imageArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selected = indexPath.row
        
        //performSegue(withIdentifier: "EventDetail", sender: nil)
    }
    

}
