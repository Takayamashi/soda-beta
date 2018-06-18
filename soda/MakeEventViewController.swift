//
//  MakeEventViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/30.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class MakeEventViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate, UITextViewDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var eventname: UITextField!
    @IBOutlet weak var university: UITextField!
    @IBOutlet weak var eventfee: UITextField!
    @IBOutlet weak var eventplace: UITextField!
    @IBOutlet weak var eventterms: UITextField!
    @IBOutlet weak var eventcontact: UITextField!
    @IBOutlet weak var eventcontent: UITextView!
    
    var myLeftButton: UIBarButtonItem!
    var mainViewController: UIViewController!
    
    
    var txtActiveField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainController = storyboard?.instantiateViewController(withIdentifier: "Main") as! HomeViewController
        self.mainViewController = UINavigationController(rootViewController: mainController)
        
        // Delegate を設定
        scrollView.delegate = self
        // textfiled用Delegate
        eventname.delegate = self
        university.delegate = self
        eventfee.delegate = self
        eventplace.delegate = self
        eventterms.delegate = self
        eventcontent.delegate = self
        eventcontact.delegate = self
        
        // 左ボタンを作成する.
        myLeftButton = UIBarButtonItem(image:UIImage(named: "back"), style: .plain, target: self, action: #selector(clickbackButton(sender:)))

        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.leftBarButtonItem = myLeftButton
        
        setnavigationBar()
    }
    
    
    @IBAction func CheckBoxTaped(_ sender: CheckBoxUIButton) {
        print(sender.isChecked)
    }
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        txtActiveField = textField
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        eventname.resignFirstResponder()
        university.resignFirstResponder()
        eventfee.resignFirstResponder()
        eventplace.resignFirstResponder()
        eventterms.resignFirstResponder()
        eventcontent.resignFirstResponder()
        eventcontact.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtActiveField.resignFirstResponder()
        
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeObserver()
    }
    
    // Notificationを設定
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Notificationを削除
    func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    // Keyboardが現れた時Viewをずらす。
    @objc func keyboardWillShow(notification: Notification?) {
        //上のTextFieldをタップする時そのまま、下のTextFieldをタップする時Viewをずらす。
        if txtActiveField.isFirstResponder || eventcontent.isFirstResponder {
            let rect = (notification?.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duration!, animations: { () in
                let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
                self.view.transform = transform
            })
        }
    }
    
    // Keyboardが消えたときViewを戻す
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
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
        self.navigationItem.title = "イベントの作成"
        
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
    
    @IBAction func Next(_ sender: Any) {
        self.performSegue(withIdentifier: "confirmevent", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
