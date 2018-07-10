//
//  MakeEventViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/30.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

extension UIScrollView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}

class MakeEventViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate, UITextViewDelegate, UIViewControllerTransitioningDelegate {
    
    
    @IBOutlet weak var BelowView: UIView!
    @IBOutlet weak var MainView: UIView!
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var eventname: UITextField!
    @IBOutlet weak var university: UITextField!
    @IBOutlet weak var eventfee: UITextField!
    @IBOutlet weak var eventplace: UITextField!
    @IBOutlet weak var eventterms: UITextField!
    @IBOutlet weak var eventcontact: UITextField!
    @IBOutlet weak var eventcontent: UITextView!
    
    
    //responsive
    var resizedView: CGSize?
    
    @IBOutlet weak var space_bottom: UIView!
    @IBOutlet weak var space_bottom_width: NSLayoutConstraint!
    @IBOutlet weak var space_bottom_height: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var theme: UIButton!
    @IBOutlet weak var album: UIButton!
    @IBOutlet weak var themeview: UIView!
    @IBOutlet weak var albumview: UIView!
    @IBOutlet weak var themeimage: UIImageView!
    @IBOutlet weak var imageheight: NSLayoutConstraint!
    @IBOutlet weak var imagewidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var eventnameheight: NSLayoutConstraint!
    @IBOutlet weak var eventnamewidth: NSLayoutConstraint!
    @IBOutlet weak var eventnameView: UIView!
    
    
    
    
    
    
    
    @IBOutlet weak var univaddTextField: UnivPickerTextField!
    
    
    var myLeftButton: UIBarButtonItem!
    var mainViewController: UIViewController!
    
    // ボタン作成
    var searchButton: UIBarButtonItem?
    var noteButton: UIBarButtonItem?
    
    
    var txtActiveField = UITextField()
    
    func resize(resizeView: CGSize, resizer: CGSize) -> CGSize{
        resizedView?.width = resizeView.width  * (resizer.width/375.0)
        resizedView?.height = resizeView.height  * (resizer.height/375.0)
        resizedView = CGSize(width: resizeView.width  * (resizer.width/375.0), height: resizeView.height  * (resizer.height/375.0))
        
        return resizedView!
    }
    
    func resize_view(resizeView: CGSize, resizer: CGSize) -> CGSize{
        resizedView?.width = resizeView.width  * (resizer.width/375.0)
        resizedView?.height = resizeView.height  * (resizer.height/375.0)
        resizedView = CGSize(width: resizeView.width  * (resizer.width/375.0), height: resizeView.height)
        
        return resizedView!
    }
    
    /*
    func resize_h(resizeView: CGSize, resizer: CGSize){
        var resizedView: CGSize
        
        resizedView.height = resizeView.height  * (resizer.height/375.0)
        
        return resizedView.height
    }
 */
    
    /*
    func responsive(responsivesize:CGSize){
        if(responsivesize.width == 375.0 && responsivesize.height == 667.0){
            //iphone8
            
        }else if(responsivesize.width == 320.0 && responsivesize.height == 568.0){
            //iphoneSE
            space_bottom_height.constant = space_bottom_height.constant*(responsivesize.height/667.0)
            space_bottom_width.constant = space_bottom_width.constant*(responsivesize.width/375.0)
            
            //theme
            theme.frame.size = resize(resizeView: theme.frame.size, resizer: responsivesize)
            themeview.frame.size = resize_view(resizeView: themeview.frame.size, resizer: responsivesize)
            
            //album
            album.frame.size = resize(resizeView: album.frame.size, resizer: responsivesize)
            albumview.frame.size = resize_view(resizeView: albumview.frame.size, resizer: responsivesize)
            
            //image
            imageheight.constant = imageheight.constant*(responsivesize.height/667.0)
            imagewidth.constant = imagewidth.constant*(responsivesize.width/375.0)
            
            //eventview
            eventnameView.frame.size = resize_view(resizeView: eventnameView.frame.size, resizer: responsivesize)
            
            
        }else if(responsivesize.width == 414.0 && responsivesize.height == 736.0){
            //iphone8plus
            
            //theme
            theme.frame.size = resize(resizeView: theme.frame.size, resizer: responsivesize)
            themeview.frame.size = resize_view(resizeView: themeview.frame.size, resizer: responsivesize)
            
            //album
            album.frame.size = resize(resizeView: album.frame.size, resizer: responsivesize)
            albumview.frame.size = resize_view(resizeView: albumview.frame.size, resizer: responsivesize)
            
            //image
            imageheight.constant = imageheight.constant*(responsivesize.height/667.0)
            imagewidth.constant = imagewidth.constant*(responsivesize.width/375.0)
            
            eventnameView.frame.size = resize_view(resizeView: eventnameView.frame.size, resizer: responsivesize)
            
        }else if(responsivesize.width == 375.0 && responsivesize.height == 812.0){
            //iphoneX
            space_bottom_height.constant = space_bottom_height.constant*(responsivesize.height/667.0)
            space_bottom_width.constant = space_bottom_width.constant*(responsivesize.width/375.0)
            
            //theme
            theme.frame.size = resize(resizeView: theme.frame.size, resizer: responsivesize)
            themeview.frame.size = resize_view(resizeView: themeview.frame.size, resizer: responsivesize)
            
            //album
            album.frame.size = resize(resizeView: album.frame.size, resizer: responsivesize)
            albumview.frame.size = resize_view(resizeView: albumview.frame.size, resizer: responsivesize)
            
            //image
            imageheight.constant = imageheight.constant*(responsivesize.height/667.0)
            imagewidth.constant = imagewidth.constant*(responsivesize.width/375.0)
            
            eventnameView.frame.size = resize_view(resizeView: eventnameView.frame.size, resizer: responsivesize)
            
        }
        
    }
 */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let responsizer = appDelegate.display
        
        //responsive(responsivesize: responsizer!)
        
        searchButton = UIBarButtonItem(image: UIImage(named: "search20")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        noteButton = UIBarButtonItem(image: UIImage(named: "notification20")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
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
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtActiveField.resignFirstResponder()
        
        return true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.configureObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeObserver()
        print("willdisappear")
        
        /*
        self.view.layer.removeAllAnimations()
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
         */
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        /*
        self.view.layer.removeAllAnimations()
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        */
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
    
    func setnavigationBar2(){
        
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
    
    
    
    
    @objc func clickbackButton(sender: UIButton){
        //setnavigationBar2()
        
        
        /*
        let mainController = storyboard?.instantiateViewController(withIdentifier: "Main") as! HomeViewController
        MainView = mainController.wholeView
        self.view.layer.removeAllAnimations()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        */
 
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            // your code here
    self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        
        //self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
 
        //}
    }
    
    
    @IBAction func Next(_ sender: Any) {
        let ConfirmEventstoryboard: UIStoryboard = UIStoryboard(name: "MakeEvent", bundle: nil)
        let ConfirmEventView = ConfirmEventstoryboard.instantiateViewController(withIdentifier: "Confirm") as! ConfirmViewController
        self.show(ConfirmEventView, sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func adduniv(_ sender: Any) {
        
        let add:String = univaddTextField.text!
        
        if university.text != ""{
            if university.text!.contains(add){
            }else{
                let universities: String = university.text! + ", " + add
                university.text = universities
            }
        }
        else{
            let universities: String = university.text! + add
            university.text = universities
        }
        
    }
    
}

