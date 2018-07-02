//
//  LeftViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/06/03.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift



class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SlideMenuControllerDelegate {
    
    var madeeventViewController: UIViewController!
    var makeeventViewController: UIViewController!
    var profileconfigViewController: UIViewController!
    var mainViewController: UIViewController!
    var agreementViewController: UIViewController!
    
    var imageArray = [UIImage]()
    var stringArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let profileconfigController = storyboard?.instantiateViewController(withIdentifier: "ProfileConfig") as! ProfileConfigViewController
        self.profileconfigViewController = UINavigationController(rootViewController: profileconfigController)
        
        let makeeventController = storyboard?.instantiateViewController(withIdentifier: "MakeEvent") as! MakeEventViewController
        self.makeeventViewController = UINavigationController(rootViewController: makeeventController)
        
        let madeeventController = storyboard?.instantiateViewController(withIdentifier: "MadeEvent") as! MadeEventViewController
        self.madeeventViewController = UINavigationController(rootViewController: madeeventController)
        
        let agreementController = storyboard?.instantiateViewController(withIdentifier: "Agreement") as! AgreementViewController
        self.agreementViewController = UINavigationController(rootViewController: agreementController)
        
        
        
        let image0 = UIImage(named: "pencil25")
        let image1 = UIImage(named: "made2")
        let image2 = UIImage(named: "clip25")
        let image3 = UIImage(named: "q&a")
        let image4 = UIImage(named: "mail")
        let image5 = UIImage(named: "logout")
        
        imageArray = [image0!, image1!, image2!, image3!, image4!, image5!]
        stringArray = ["イベントを作成", "作成したイベント", "利用規約", "Q&A", "お問い合わせ", "ログアウト"]
        
        tableView.delegate  = self
        tableView.dataSource = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    @IBAction func ProfileButton(_ sender: Any) {
        //self.present(self.profileconfigViewController, animated: true, completion: nil)
        self.slideMenuController()?.changeMainViewController(self.profileconfigViewController, close: true)
        /*
        let Mainstoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let profileconfigController = Mainstoryboard.instantiateViewController(withIdentifier: "ProfileConfig") as! ProfileConfigViewController
        closeLeft()
        self.show(profileconfigController, sender: nil)
         */
        
        /*
        let profileconfigController = storyboard?.instantiateViewController(withIdentifier: "ProfileConfig") as! ProfileConfigViewController
        let nextVC = ProfileConfigViewController()
        let naviVC = UINavigationController(rootViewController: nextVC)
        naviVC.view = profileconfigController.MainView
        self.present(naviVC, animated: true, completion: nil)
         */
    }
    @IBAction func Profilename(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.profileconfigViewController, close: true)
    }
    
    //tableviewのデリゲートメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let cellimage = cell.viewWithTag(1) as! UIImageView
        let celllabel = cell.viewWithTag(2) as! UILabel
        
        cellimage.image = imageArray[indexPath.row]
        celllabel.text = stringArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = indexPath.row
        if(selected == 0){
            self.slideMenuController()?.changeMainViewController(self.makeeventViewController, close: true)
            //let SlideMenuController = SlideMenuController(mainViewController:mainViewController, rightMenuViewController:self.rightViewController)
        }else if(selected == 1){
            self.slideMenuController()?.changeMainViewController(self.madeeventViewController, close: true)
        }else if(selected == 2){
            self.slideMenuController()?.changeMainViewController(self.agreementViewController, close: true)
        }
        
        //performSegue(withIdentifier: "EventDetail", sender: nil)
    }
    

}
