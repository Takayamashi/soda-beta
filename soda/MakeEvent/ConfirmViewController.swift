//
//  ConfirmViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/26.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    @IBOutlet weak var eventnamelabel: UILabel!
    
    
    @IBOutlet weak var eventmonthlabel: UILabel!
    @IBOutlet weak var eventdaylabel: UILabel!
    @IBOutlet weak var universitylabel: UILabel!
    @IBOutlet weak var eventimageView: UIImageView!
    @IBOutlet weak var eventfeelabel: UILabel!
    @IBOutlet weak var eventplacelabel: UILabel!
    
    @IBOutlet weak var eventstartdaytimelabel: UILabel!
    
    @IBOutlet weak var eventtermslabel: UILabel!
    @IBOutlet weak var eventcontentlabel: UILabel!
    @IBOutlet weak var eventcontactlabel: UILabel!
    
    
    
    @IBOutlet weak var organizernamelabel: UILabel!
    @IBOutlet weak var organizeprofilelabel: UILabel!

    
    var eventname: String?
    var eventmonth: String?
    var eventday: String?
    var university: String?
    var eventimage: UIImage?
    var eventfee: String?
    var eventplace: String?
    var eventstartdaytime: String?
    var eventterms: String?
    var eventcontent: String?
    var eventcontact: String?
    var organizername: String?
    var organizeprofile: String?
    var closechecked: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
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
    
    func setContent(){
        eventnamelabel.text = eventname
        eventdaylabel.text = eventday
        universitylabel.text = university
        eventfeelabel.text = eventfee
        eventplacelabel.text = eventplace
        eventstartdaytimelabel.text = eventstartdaytime
        eventtermslabel.text = eventterms
        eventcontentlabel.text = eventcontent
        eventcontactlabel.text = eventcontact
        print(closechecked!)
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
