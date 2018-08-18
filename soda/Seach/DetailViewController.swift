//
//  DetailViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/08/18.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //選択された要素を入れる。表示にも使い回す。
    var text = "none"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setnavigationBar()
        self.view.backgroundColor = UIColor.white//背景を白色にする
        let label: UILabel = UILabel()//ラベルを作る
        label.text = text//ラベルのテキストを選択された文字列にする
        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)//ラベルの大きさを設定する
        label.center = self.view.center//ラベルの位置を真ん中にする
        label.textAlignment = .center//テキストを中央揃えにする
        self.view.addSubview(label)//ラベルを表示する
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"logo_white_small"))
        
    }
}
