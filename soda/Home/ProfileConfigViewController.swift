//
//  ProfileConfigViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/07.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import RSKImageCropper


class ProfileConfigViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, RSKImageCropViewControllerDelegate{
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var univaddTextField: UnivPickerTextField!
    @IBOutlet weak var univTextField: UITextField!
    
    @IBOutlet weak var mailAdressTextField: UITextField!
    
    @IBOutlet weak var ProfileTextView: TextViewLine!
    
    @IBOutlet weak var twitterAccountName: UITextField!
    @IBOutlet weak var facebookAccountName: UITextField!
    
    
    var mainViewController: UIViewController!
    
    
    @IBOutlet weak var MainView: UIView!
    var myLeftButton: UIBarButtonItem!
    
    //textfieldが選択された際の格納変数
    var txtActiveField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 左ボタンを作成する.
        myLeftButton = UIBarButtonItem(image:UIImage(named: "back"), style: .plain, target: self, action: #selector(clickbackButton(sender:)))
        
        let mainController = storyboard?.instantiateViewController(withIdentifier: "Main") as! HomeViewController
        self.mainViewController = UINavigationController(rootViewController: mainController)
        
        //ナビゲーションバーの右側にボタン付与
        self.navigationItem.leftBarButtonItem = myLeftButton
        
        setProfile()

        self.setnavigationBar()
    }
    
    
    func setProfile(){
        if UserDefaults.standard.object(forKey: "profileImage") != nil{
            //Profile画像参照
            let decodeData = (base64Encoded: UserDefaults.standard.object(forKey: "profileImage"))
            let decodedData = NSData(base64Encoded: decodeData as! String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            let decodedImage = UIImage(data:decodedData! as Data)
            profileImageView.image = decodedImage!
        }
        
        if UserDefaults.standard.object(forKey: "username") != nil{
            userNameTextField.text = UserDefaults.standard.object(forKey: "username") as? String
        }
        
        if UserDefaults.standard.object(forKey: "indicateuniv") != nil{
            univTextField.text = UserDefaults.standard.object(forKey: "indicateuniv") as? String
        }
        
        if UserDefaults.standard.object(forKey: "mailadress") != nil{
            mailAdressTextField.text = UserDefaults.standard.object(forKey: "mailadress") as? String
        }
        
        if UserDefaults.standard.object(forKey: "profiletext") != nil{
            ProfileTextView.text = UserDefaults.standard.object(forKey: "profiletext") as? String
        }
        
        if UserDefaults.standard.object(forKey: "twitteraccount") != nil{
            twitterAccountName.text = UserDefaults.standard.object(forKey: "twitteraccount") as? String
        }
        
        if UserDefaults.standard.object(forKey: "facebookaccount") != nil{
            facebookAccountName.text = UserDefaults.standard.object(forKey: "facebookaccount") as? String
        }
        
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
    
    @IBAction func changeProfileView(_ sender: Any) {
        let alertViewController = UIAlertController(title: "プロフィール写真を設定します", message: "", preferredStyle: .actionSheet)
        
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
        
        let image : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        imagePicker.dismiss(animated: false, completion: { () -> Void in
            
            var imageCropVC : RSKImageCropViewController!
            
            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.circle)
            
            imageCropVC.moveAndScaleLabel.text = "切り取り範囲を選択"
            imageCropVC.cancelButton.setTitle("キャンセル", for: .normal)
            imageCropVC.chooseButton.setTitle("完了", for: .normal)
            imageCropVC.delegate = self
            
            self.present(imageCropVC, animated: true)
            
        })
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
        
        var data: NSData = NSData()
        if let image = profileImageView.image{
            data = UIImageJPEGRepresentation(image, 0.1)! as NSData
        }
        let profileImage64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters) as String
        let username = userNameTextField.text
        let indicateuniv = univTextField.text
        let mailadress = mailAdressTextField.text
        let profiletext = ProfileTextView.text
        let twitteraccount = twitterAccountName.text
        let facebookaccount = facebookAccountName.text
        
        //アプリ内へ保存
        UserDefaults.standard.set(profileImage64String, forKey: "profileImage")
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(indicateuniv, forKey: "indicateuniv")
        UserDefaults.standard.set(mailadress, forKey: "mailadress")
        UserDefaults.standard.set(profiletext, forKey: "profiletext")
        UserDefaults.standard.set(twitteraccount, forKey: "twitteraccount")
        UserDefaults.standard.set(facebookaccount, forKey: "facebookaccount")
        
        
        //ここでprofileImageをS3にアップロードしたい
        
        
        //サーバー用dictionary
        //let user:NSDictionary = ["profileImage": S3へアップロードした時のurlを置きたい, "username":username, "indicateuniv":indicateuniv, "mailadress":mailadress, "profiletext":profiletext, "twitteraccount":twitteraccount, "facebookaccount":facebookaccount]
        
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
    }
    
    
    
    
    @objc func clickbackButton(sender: UIButton){
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        
        
        //もし円形で画像を切り取りし、その画像自体を加工などで利用したい場合
        if controller.cropMode == .circle {
            UIGraphicsBeginImageContext(croppedImage.size)
            let layerView = UIImageView(image: croppedImage)
            layerView.frame.size = croppedImage.size
            layerView.layer.cornerRadius = layerView.frame.size.width * 0.5
            layerView.clipsToBounds = true
            let context = UIGraphicsGetCurrentContext()!
            layerView.layer.render(in: context)
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            let pngData = UIImagePNGRepresentation(capturedImage)!
            //このImageは円形で余白は透過です。
            let png = UIImage(data: pngData)!
            profileImageView.image = png
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    //トリミング画面でキャンセルを押した時
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //keyboardずらす用のnotification呼び出し
        self.configureObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //keyboardずらす用のnotification削除
        self.removeObserver()
        print("willdisappear")
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ProfileTextView.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        txtActiveField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtActiveField.resignFirstResponder()
        
        return true
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
        //上のTextFieldをタップする時そのまま、下のTextFieldをタップする時Viewをずらす
        if txtActiveField.isFirstResponder || ProfileTextView.isFirstResponder {
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
    
    

    

}
