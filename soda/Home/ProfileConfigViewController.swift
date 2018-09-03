//
//  ProfileConfigViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/07.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ProfileConfigViewController: UIViewController {
    
    let searchButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))
    let noteButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "note")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRefreshButton))

    @IBOutlet weak var univaddTextField: UnivPickerTextField!
    @IBOutlet weak var univTextField: UITextField!
    
    
    @IBOutlet weak var MainView: UIView!
    var myLeftButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 左ボタンを作成する.
        myLeftButton = UIBarButtonItem(image:UIImage(named: "back"), style: .plain, target: self, action: #selector(clickbackButton(sender:)))
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.leftBarButtonItem = myLeftButton

        self.setnavigationBar()
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        //バーの左側にボタンを配置(ライブラリ特有)
        //addLeftBarButtonWithImage(UIImage(named: "list")!)
        
        //ナビゲーションバーの右側にボタン付与
        //self.navigationItem.setRightBarButtonItems([noteButton, searchButton], animated: true)
        
        //ナビゲーションアイテムのタイトルに画像を設定する。
        //self.navigationItem.titleView = UIImageView(image:UIImage(named:"logo_white_small"))
        
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
    
    @objc func clickbackButton(sender: UIButton){
        
        //もともとのアニメーションを削除
        /*
         self.view.layer.removeAllAnimations()
         let transition = CATransition()
         transition.duration = 0.5
         transition.type = kCATransitionPush
         transition.subtype = kCATransitionFromLeft
         self.navigationController?.view.layer.add(transition, forKey: kCATransition)
         */
        
        
        
        /*
         UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
         self.MainView.center.x += self.MainView.bounds.width
         
         },completion:nil)
         */
        
        
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.249) {
        // your code here
        //delegate?.changeViewController(LeftMenu.main)
        
        
        //let nextVC = HomeViewController()
        //let naviVC = UINavigationController(rootViewController: nextVC)
        //self.present(naviVC, animated: true, completion: nil)
        
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
