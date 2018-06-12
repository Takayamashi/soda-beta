//
//  LeftViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/03.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    var makeeventViewController: UIViewController!
    var profileconfigViewController: UIViewController!
    var mainViewController: UIViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileconfigController = storyboard?.instantiateViewController(withIdentifier: "ProfileConfig") as! ProfileConfigViewController
        self.profileconfigViewController = UINavigationController(rootViewController: profileconfigController)
        
        let makeeventController = storyboard?.instantiateViewController(withIdentifier: "MakeEvent") as! MakeEventViewController
        self.makeeventViewController = UINavigationController(rootViewController: makeeventController)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ProfileButton(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.profileconfigViewController, close: true)
    }
    @IBAction func Profilename(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.profileconfigViewController, close: true)
    }
    
    @IBAction func MakeEventButton(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.makeeventViewController, close: true)
    }
    
    @IBAction func makeevent(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.makeeventViewController, close: true)
    }
    
    
    

}
