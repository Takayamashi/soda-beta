//
//  ProfileTextView.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/09.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class ProfileTextView: UITextView, UITextViewDelegate {

    // UITextViewデリゲートメソッド（textに変更があった際に呼び出される。）
    private func textViewDidChange(textView: UITextView) {
        let maxHeight = 128.0  // 入力フィールドの最大サイズ
        if(textView.frame.size.height.native < maxHeight) {
            let size:CGSize = textView.sizeThatFits(textView.frame.size)
            textView.frame.size.height = size.height
        }
    }
}
