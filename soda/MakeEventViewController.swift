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
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegate を設定
        
        scrollView.delegate = self
    }
    
    @IBAction func CheckBoxTaped(_ sender: CheckBoxUIButton) {
        print(sender.isChecked)
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        Header.frame = CGRect(x:0, y:0+scrollView.contentOffset.y, width:375, height:70)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
