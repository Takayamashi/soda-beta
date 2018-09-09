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


class MakeEventViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate, UITextViewDelegate, UIViewControllerTransitioningDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var eventimage: UIImageView!
    
    
    @IBOutlet weak var eventname: UITextField!
    @IBOutlet weak var eventfee: UITextField!
    @IBOutlet weak var eventplace: UITextField!
    @IBOutlet weak var eventterms: UITextField!
    @IBOutlet weak var eventcontact: UITextField!
    @IBOutlet weak var eventcontent: UITextView!

    @IBOutlet weak var eventstartday: DatePickerTextField!
    @IBOutlet weak var eventstarttime: TimePickerTextField!
    @IBOutlet weak var eventfinishday: DatePickerTextField!
    @IBOutlet weak var eventfinishtime: TimePickerTextField!
    @IBOutlet weak var univaddTextField: UnivPickerTextField!
    @IBOutlet weak var closecheckButton: UIButton!
    
    
    var closechecked:Bool = false
    
    
    var myLeftButton: UIBarButtonItem!
    var mainViewController: UIViewController!
    
    // ボタン作成
    var searchButton: UIBarButtonItem?
    var noteButton: UIBarButtonItem?
    
    
    var txtActiveField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let uncheckedImage = UIImage(named: "checkout")! as UIImage
        
       closecheckButton.setImage(uncheckedImage, for: UIControlState.normal)
        
        let mainController = storyboard?.instantiateViewController(withIdentifier: "Main") as! HomeViewController
        self.mainViewController = UINavigationController(rootViewController: mainController)
        
        // Delegate を設定
        scrollView.delegate = self
        // textfiled用Delegate
        eventname.delegate = self
        eventfee.delegate = self
        eventplace.delegate = self
        eventterms.delegate = self
        eventcontent.delegate = self
        eventcontact.delegate = self
        
        
        setnavigationBar()
    }
    
    
    @IBAction func uploadimage(_ sender: Any) {
        let alertViewController = UIAlertController(title: "イメージ写真を設定します", message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "カメラで撮影する", style: .default, handler:{(action:UIAlertAction?) -> Void in
            //処理
            self.openCamera()
        })
        let photoAction = UIAlertAction(title: "ライブラリから選択する", style: .default, handler:{(action:UIAlertAction?) -> Void in
            //処理
            self.openPhoto()
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alertViewController.addAction(cameraAction)
        alertViewController.addAction(photoAction)
        alertViewController.addAction(cancelAction)
        present(alertViewController, animated: true, completion: nil)
        
    }
    
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //.image = pickedImage
            eventimage.contentMode = .scaleToFill
            eventimage.image = pickedImage
            
            //写真を保存
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func openPhoto(){
        let sourceType:UIImagePickerControllerSourceType =
            UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("error")
            
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
    
    
    
    
    @IBAction func CheckBoxTaped(_ sender: Any) {
        // Images
        let checkedImage = UIImage(named: "check")! as UIImage
        let uncheckedImage = UIImage(named: "checkout")! as UIImage
        
        if closechecked == false{
            closechecked = true
            closecheckButton.setImage(checkedImage, for: UIControlState.normal)
            
        }else{
            closechecked = false
            closecheckButton.setImage(uncheckedImage, for: UIControlState.normal)
        }
        
        
        print(closechecked)
        
        
        //appdelegateよりwindowサイズを抜き出すため呼び出し
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let ConfirmEventstoryboard: UIStoryboard = UIStoryboard(name: "MakeEvent", bundle: nil)
        let ConfirmEventView414 = ConfirmEventstoryboard.instantiateViewController(withIdentifier: "Confirm414") as! ConfirmViewController
        let ConfirmEventView375 = ConfirmEventstoryboard.instantiateViewController(withIdentifier: "Confirm375") as! ConfirmViewController
        let ConfirmEventView320 = ConfirmEventstoryboard.instantiateViewController(withIdentifier: "Confirm320") as! ConfirmViewController
        
        
        if appDelegate.display?.width == 320{
            ConfirmEventView320.closechecked = closechecked
        }else if appDelegate.display?.width == 375{
            ConfirmEventView375.closechecked = closechecked
        }else if appDelegate.display?.width == 414{
            ConfirmEventView414.closechecked = closechecked
        }
        
    }
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        txtActiveField = textField
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        eventcontent.resignFirstResponder()
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
        
    }
    
    // Keyboardが現れた時ViewをずらすためのNotificationを設定
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
    
    // Keyboardが現れた時Viewをずらす
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
        
        // 左ボタンを作成する.
        myLeftButton = UIBarButtonItem(image:UIImage(named: "back"), style: .plain, target: self, action: #selector(clickbackButton(sender:)))
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.leftBarButtonItem = myLeftButton
        
        //次の画面に戻るボタン設置
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.title = "イベントの作成"
        
    }
    
    
    @objc func clickbackButton(sender: UIButton){
        
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
    }
    
    
    @IBAction func Next(_ sender: Any) {
        eventinfo2confirm()
    }
    
    
    @IBAction func themeButtonTapped(_ sender: Any) {
        let ThemeSelectedstoryboard: UIStoryboard = UIStoryboard(name: "MakeEvent", bundle: nil)
        
        let ThemeSelectedView = ThemeSelectedstoryboard.instantiateViewController(withIdentifier: "ThemeSelect") as! ThemeSelectViewController
        
        self.show(ThemeSelectedView, sender: nil)
        
    }
    
    
    func eventinfo2confirm(){
        //appdelegateよりwindowサイズを抜き出すため呼び出し
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let ConfirmEventstoryboard: UIStoryboard = UIStoryboard(name: "MakeEvent", bundle: nil)
        let ConfirmEventView414 = ConfirmEventstoryboard.instantiateViewController(withIdentifier: "Confirm414") as! ConfirmViewController
        let ConfirmEventView375 = ConfirmEventstoryboard.instantiateViewController(withIdentifier: "Confirm375") as! ConfirmViewController
        let ConfirmEventView320 = ConfirmEventstoryboard.instantiateViewController(withIdentifier: "Confirm320") as! ConfirmViewController
        
        
        
        if appDelegate.display?.width == 320{
            ConfirmEventView320.eventname = eventname.text
            
            if let eventday = eventstartday.text{
                let eventstartdayarray = eventday.split(separator: "/")
                let eventweekdayarray = eventstartdayarray[2].split(separator: " ")
                ConfirmEventView320.eventmonth = String(eventstartdayarray[1]) + "月"
                ConfirmEventView320.eventday = String(eventweekdayarray[0]) + "日" + String(eventweekdayarray[1])
            }
            
            
            
            
            self.show(ConfirmEventView320, sender: nil)
        }else if appDelegate.display?.width == 375{
            ConfirmEventView375.eventname = eventname.text
            if let eventday = eventstartday.text{
                let eventstartdayarray = eventday.split(separator: "/")
                let eventweekdayarray = eventstartdayarray[2].split(separator: " ")
                ConfirmEventView375.eventmonth = String(eventstartdayarray[1]) + "月"
                ConfirmEventView375.eventday = String(eventweekdayarray[0]) + "日" + String(eventweekdayarray[1])
            }
            
            self.show(ConfirmEventView375, sender: nil)
            
            
        }else if appDelegate.display?.width == 414{
            if let eventnamestring = eventname.text{
                print(eventnamestring)
                ConfirmEventView414.eventname = eventnamestring
            }
            
            if let university = univaddTextField.text{
                
                ConfirmEventView414.university = university
            }
            
            if let eventfee = eventfee.text{
                ConfirmEventView414.eventfee = eventfee
            }
            
            if let eventplace = eventplace.text{
                ConfirmEventView414.eventplace = eventplace
            }
            
            if let eventstartday = eventstartday.text{
                if let eventstarttime = eventstarttime.text{
                    let eventstartdayarray = eventstartday.split(separator: "/")
                    let eventweekdayarray = eventstartdayarray[2].split(separator: " ")
                    ConfirmEventView414.eventmonth = String(eventstartdayarray[1]) + "月"
                    ConfirmEventView414.eventday = String(eventweekdayarray[0]) + "日" + String(eventweekdayarray[1])
                    
                    ConfirmEventView414.eventstartdaytime = eventstartday + eventstarttime
                }
                
            }
            
            if let eventterms = eventterms.text{
                ConfirmEventView414.eventterms = eventterms
                
            }
            
            if let eventcontent = eventcontent.text{
                ConfirmEventView414.eventcontent = eventcontent
            }
            
            if let eventcontact = eventcontact.text{
                ConfirmEventView414.eventcontact = eventcontact
            }
            
            ConfirmEventView414.closechecked = closechecked
            
            
            
            self.show(ConfirmEventView414, sender: nil)
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

