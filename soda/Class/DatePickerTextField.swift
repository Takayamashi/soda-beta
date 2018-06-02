//
//  DatePickerTextField.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/31.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class DatePickerTextField: UITextField {

    let datePicker = UIDatePicker()
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(createDatePicker), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
    }
    
    @objc func createDatePicker(){
        
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .date
        
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        
        // textFieldのinputViewにdatepickerを設定
        self.inputView = datePicker
        
        // UIToolbarを設定
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        // Doneボタンを追加
        toolbar.setItems([doneButton], animated: true)
        
        // FieldにToolbarを追加
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        let dateFormatter = DateFormatter()
        
        // 持ってくるデータのフォーマットを設定
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        // textFieldに選択した日付を代入
        super.text = dateFormatter.string(from: datePicker.date)
        
        // キーボードを閉じる
        self.resignFirstResponder()
    }

}
