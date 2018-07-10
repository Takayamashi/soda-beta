//
//  UILabel+change.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/07/03.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

@IBDesignable

class ISTDynamicLabel : UILabel {
    // 基準とする画面横幅
    let baseScreenWidth : CGFloat = 375.0
    
    @IBInspectable var lineHeight : CGFloat = 0.0 {
        didSet {
            // lineHeightの値が変更された際に呼び出す
            fixLineHeight()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        changeFontSize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        changeFontSize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fixLineHeight()
    }
    
    override var text: String? {
        didSet {
            fixLineHeight()
        }
    }
    
    /**
     画面比率に応じて、フォントサイズを変更します
     */
    private func changeFontSize() {
        self.font = UIFont(name: font.fontName, size: self.font.pointSize * getScreenRatio())
    }
    
    /**
     画面比率に応じて行間を変更します
     */
    private func fixLineHeight() {
        if lineHeight > 0.0 {
            let paragrahStyle = NSMutableParagraphStyle()
            paragrahStyle.alignment = self.textAlignment
            let fixedLineHeight = floor(lineHeight * getScreenRatio())
            paragrahStyle.minimumLineHeight = fixedLineHeight
            paragrahStyle.maximumLineHeight = fixedLineHeight
            let attributedText = NSMutableAttributedString(attributedString: self.attributedText!)
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragrahStyle, range: NSRange(location: 0, length: attributedText.length))
            self.attributedText = attributedText
        }
    }
    
    /**
     baseScreenWidthと、画面の横幅との比率を返します
     - returns: 画面比率
     */
    private func getScreenRatio() -> CGFloat {
        return UIScreen.main.bounds.size.width / baseScreenWidth
    }
}
