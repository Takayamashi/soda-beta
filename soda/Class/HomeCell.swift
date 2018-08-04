//
//  HomeCell.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/07/23.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

protocol CellDelegate {
    func buttonDidTap()
}

import UIKit

class HomeCell: UITableViewCell {
    
    var count: Int = 0
    
    let checkedImage = UIImage(named: "goodchecked")! as UIImage
    let uncheckedImage = UIImage(named: "goodbutton")! as UIImage
    
    override func awakeFromNib() {
        super.awakeFromNib()
        count = 0
    }
    
    @IBOutlet weak var GoodCount: UILabel!
    
    @IBOutlet weak var GoodButton: UIButton!
    
    /*
    @IBAction func GoodButtonTapped(_ sender: Any) {
        let row = self.tag
        print(row)
        
        if count == 0{
            GoodButton.setImage(uncheckedImage, for: UIControlState.normal)
            count += 1
        }else{
            GoodButton.setImage(checkedImage, for: UIControlState.normal)
            count  = 0
        }
        
        
        if count == 1{
            GoodCount.text = String(Int(GoodCount.text!)! + 1)
        }else{
            GoodCount.text = String(Int(GoodCount.text!)! - 1)
        }
 
    }
 */
    
    
    
    
   
    
}
