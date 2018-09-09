//
//  DatePickerTextField.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/05/31.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit


extension DateFormatter {
    // テンプレートの定義(例)
    enum Template: String {
        case date = "yMd"     // 2017/1/1
        case time = "Hms"     // 12:39:22
        case full = "yMdkHms" // 2017/1/1 12:39:22
        case onlyHour = "k"   // 17時
        case era = "GG"       // "西暦" (default) or "平成" (本体設定で和暦を指定している場合)
        case weekDay = "E" // 日曜日
        
        case soda = "yMdkE"
    }
    // 冗長な関数のためラップ
    func setTemplate(_ template: Template) {
        // optionsは拡張のためにあるが使用されていない引数
        // localeは省略できないがほとんどの場合currentを指定する
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}


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
        
        let weekFormatter = DateFormatter()
        weekFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?
        weekFormatter.setTemplate(.weekDay)
        
        super.text = super.text! + " " + "(" + weekFormatter.string(from: datePicker.date) + ")"
        
        // キーボードを閉じる
        self.resignFirstResponder()
    }

}
