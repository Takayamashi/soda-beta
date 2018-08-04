//
//  UIImage+changesize.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/08/04.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

@IBDesignable

class ISTDynamicImage : UIImageView {
    // 基準とする画面横幅
    let baseScreenWidth : CGFloat = 375.0
    let baseScreenHeight : CGFloat = 667.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let rect:CGRect = CGRect(x:0, y:0, width:self.frame.width*getScreenWidthRatio(), height:self.frame.height*getScreenHeightRatio())
        self.frame = rect
    }
    
    /**
     画面比率に応じて、フォントサイズを変更します
     */
    
    /**
     画面比率に応じて行間を変更します
     */
    /**
     baseScreenWidthと、画面の横幅との比率を返します
     - returns: 画面比率
     */
    private func getScreenWidthRatio() -> CGFloat {
        return UIScreen.main.bounds.size.width / baseScreenWidth
    }
    
    private func getScreenHeightRatio() -> CGFloat {
        return UIScreen.main.bounds.size.height / baseScreenHeight
    }
}
