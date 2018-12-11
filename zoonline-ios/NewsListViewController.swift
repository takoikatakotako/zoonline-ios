//
//  NewsListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/09.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


protocol NewsDelegate: class  {
    func openNews(newsUrl: String)
}

class NewsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var statusBarHeight: CGFloat!
    var navigationBarHeight: CGFloat!
    var pageMenuHeight: CGFloat!
    var tabBarHeight: CGFloat!
    private var tableViewHeight: CGFloat!

    var newsContents: JSON = []

    //delegate
    weak var delegate: NewsDelegate?
    
    
    //テーブルビューインスタンス
    private var newsTableView: UITableView!
    
    //サポートボタン
    var supportBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+pageMenuHeight+tabBarHeight)
        
        setTableView()
        getNews()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let didSupport: Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_Zoo"))!
        if !didSupport {
            setSupportBtn()
        }
    }
    
    func setTableView() {
        //テーブルビューの初期化
        newsTableView = UITableView()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        newsTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        newsTableView.rowHeight = viewWidth*0.28
        if #available(iOS 11.0, *) {
            newsTableView.contentInsetAdjustmentBehavior = .never
        }
        self.view.addSubview(newsTableView)
    }
    
    func setSupportBtn() {
        //サポート
        supportBtn = UIButton()
        supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        supportBtn.setImage(UIImage(named: "support_official"), for: UIControl.State.normal)
        supportBtn.imageView?.contentMode = UIView.ContentMode.bottomRight
        supportBtn.contentHorizontalAlignment = .fill
        supportBtn.contentVerticalAlignment = .fill
        supportBtn.backgroundColor = UIColor.clear
        supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(supportBtn)
    }
    
    
    
    // MARK: ButtonActions
    @objc func supportBtnClicked(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_Zoo")
        supportBtn.removeFromSuperview()
    }
    
    func getNews() {
        
        Alamofire.request(EveryZooAPI.getZooNews()).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json: JSON = JSON(response.result.value ?? kill)
                //print(json)
                print(json["is_success"].stringValue)
                //print(json["content"].arrayValue)
                self.newsContents = json["content"]
                self.newsTableView.reloadData()
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
    
    
    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return self.newsContents.count
    }
    
    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell

        let dates = UtilityLibrary.parseDates(text: self.newsContents[indexPath.row]["posted_at"].stringValue)
        var dateText: String = dates["year"]! + "/"
        dateText += dates["month"]! + "/"
        dateText += dates["day"]!
        cell.dateLabel.text = dateText
        
        cell.titleLabel.text = self.newsContents[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.newsContents[indexPath.row]["content"].stringValue
        let imageUrl = URL(string: self.newsContents[indexPath.row]["image_url"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        return cell
    }
    
    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.openNews(newsUrl: self.newsContents[indexPath.row]["article_url"].stringValue)
    }
}
