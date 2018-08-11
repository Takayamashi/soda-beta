//
//  ResponsivelineChange.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/08/11.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class ResponsiveLine: UIView {
    
    //responsive
    var resizedView: CGSize?
    
    override func awakeFromNib() {
        
    }
    
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
}
