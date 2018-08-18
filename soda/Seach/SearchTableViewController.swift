//
//  SearchTableViewController.swift
//  soda
//
//  Created by Ryuichi Takayama on 2018/08/18.
//  Copyright © 2018年 Ryuichi Takayama. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, SelectedCellProtocol {
    
    //データを定義
    let data: [String] = ["立命館",
                          "5月30日"]
    
    //UISearchControllerの変数を作成
    var mySearchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setnavigationBar()
        
        //セルの名前を設定
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //検索に関する設定
        let resultController = SearchResultViewController()
        resultController.delegate = self
        mySearchController = UISearchController(searchResultsController: resultController) //検索結果を表示するViewを設定
        mySearchController.hidesNavigationBarDuringPresentation = true//検索バーを押したらナビゲーションバーが隠れる
        mySearchController.dimsBackgroundDuringPresentation = true//検索中は後ろが暗くなる。
        self.definesPresentationContext = true
        let searchBar = mySearchController.searchBar
        searchBar.delegate = resultController
        //searchBar.placeholder = "空白区切りで検索" //placeholderを設定
        //searchBar.scopeButtonTitles = ["どれか含む", "全て含む"] //Scopeボタンのタイトルを設定
        searchBar.searchBarStyle = .default //なくてもいい
        searchBar.barStyle = .default //なくてもいい
        //searchbarのbackgroundを変更
        /*
        let barImageView = searchBar.value(forKey: "_background") as! UIImageView
        barImageView.removeFromSuperview()
        
        searchBar.backgroundColor = UIColor.yellow
        */
        
        
        self.tableView.tableHeaderView = searchBar //TableViewの一番上にsearchBarを設置
        searchBar.sizeToFit()
        mySearchController.searchResultsUpdater = resultController //検索されると動くViewを設定
        
        //ForceTouch
        if #available(iOS 9.0, *){
            resultController.forceTouch = self.traitCollection.forceTouchCapability
            if self.traitCollection.forceTouchCapability == .available{
                self.registerForPreviewing(with: self, sourceView: self.view)
            }
        }
    }
    
    func setnavigationBar(){
        //NavigationBarが半透明かどうか
        navigationController?.navigationBar.isTranslucent = false
        //NavigationBarの色を変更
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 128/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"logo_white_small"))
        //次の画面に戻るボタン設置
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didSelectedCell(view: DetailViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func didPopCell(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if #available(iOS 9.0, *) {
            self.previewingContext(previewingContext, commit: viewControllerToCommit)
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //セルに表示するテキストを設定
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailView = DetailViewController()
        DetailView.text = data[indexPath.row]
        self.navigationController?.pushViewController(DetailView, animated: true)
    }
}

@available(iOS 9.0, *)
extension SearchTableViewController: UIViewControllerPreviewingDelegate{
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        print("peek")
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}

//Protocols
protocol SelectedCellProtocol: class {
    func didSelectedCell(view: DetailViewController)
    func didPopCell(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
}

extension SelectedCellProtocol{
    func didPopCell(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController){
        
    }
}
