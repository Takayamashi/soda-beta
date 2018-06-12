//
//  ProfileConfigViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/07.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class ProfileConfigViewController: UIViewController {
    
    let searchButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))
    let noteButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "note")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))

    @IBOutlet weak var univaddTextField: UnivPickerTextField!
    @IBOutlet weak var univTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @objc func clickSearchButton(){
        //searchButtonを押した際の処理を記述
    }
    
    @objc func clickRefreshButton(){
        //refreshButtonを押した際の処理を記述
    }
    
    @IBAction func adduniv(_ sender: Any) {
        
        let add:String = univaddTextField.text!
        
        if univTextField.text != ""{
            if univTextField.text!.contains(add){
            }else{
                let universities: String = univTextField.text! + ", " + add
                univTextField.text = universities
            }
        }
        else{
            let universities: String = univTextField.text! + add
            univTextField.text = universities
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
