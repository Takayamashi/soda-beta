//
//  MakeEventViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/30.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class MakeEventViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var Header: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var eventname: UITextField!
    @IBOutlet weak var university: UITextField!
    @IBOutlet weak var eventfee: UITextField!
    @IBOutlet weak var eventplace: UITextField!
    @IBOutlet weak var eventterms: UITextField!
    @IBOutlet weak var eventcontent: UITextField!
    @IBOutlet weak var eventcontact: UITextField!
    
    
    
    
    var txtActiveField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    
    @IBAction func CheckBoxTaped(_ sender: CheckBoxUIButton) {
        print(sender.isChecked)
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        Header.frame = CGRect(x:0, y:0+scrollView.contentOffset.y, width:375, height:70)
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
        if txtActiveField.isFirstResponder {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
