//
//  UnivPickerTextField.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/08.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class UnivPickerTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    let univPicker = UIPickerView()
    var univ = ["立命館大学","同志社大学","京都大学","東京大学"]
    
    
    override func awakeFromNib() {
        univPicker.delegate = self
        univPicker.dataSource = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(createDatePicker), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return univ.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        super.text = univ[row]
        return univ[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        super.text = univ[row]
    }
    
    
    @objc func createDatePicker(){
        
        // textFieldのinputViewにdatepickerを設定
        self.inputView = univPicker
        
        // UIToolbarを設定
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelClicked))
        
        // Doneボタンを追加
        toolbar.setItems([cancelButton, doneButton], animated: true)
        
        // FieldにToolbarを追加
        self.inputAccessoryView = toolbar
    }
    
    
    @objc func doneClicked(){
        
        // キーボードを閉じる
        self.resignFirstResponder()
    }
    
    @objc func cancelClicked(){
        super.text = nil
        // キーボードを閉じる
        self.resignFirstResponder()
    }
    
    

}
