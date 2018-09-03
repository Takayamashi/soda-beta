//
//  ProfileConfigViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/07.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift


class ProfileConfigViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var univaddTextField: UnivPickerTextField!
    @IBOutlet weak var univTextField: UITextField!
    var mainViewController: UIViewController!
    
    
    @IBOutlet weak var MainView: UIView!
    var myLeftButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 左ボタンを作成する.
        myLeftButton = UIBarButtonItem(image:UIImage(named: "back"), style: .plain, target: self, action: #selector(clickbackButton(sender:)))
        
        let mainController = storyboard?.instantiateViewController(withIdentifier: "Main") as! HomeViewController
        self.mainViewController = UINavigationController(rootViewController: mainController)
        
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
    
    @IBAction func saveprofile(_ sender: Any) {
        
    }
    
    
    
    
    @objc func clickbackButton(sender: UIButton){
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openPhoto(){
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    func openCamera(){
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    

    

}
