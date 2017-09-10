//
//  NewsListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/09.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage


protocol NewsDelegate: class  {
    func openNews(newsUrl:String)
}

class NewsListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    //
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    var pageMenuHeight:CGFloat!
    var tabBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!

    var newsContents:JSON = []

    //delegate
    weak var delegate: NewsDelegate?
    
    
    //テーブルビューインスタンス
    private var newsTableView: UITableView!
    
    //サポートボタン
    let supportBtn:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+pageMenuHeight+tabBarHeight)
        
        getNews()
        //テーブルビューの初期化
        newsTableView = UITableView()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        newsTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        newsTableView.rowHeight = viewWidth*0.28
        self.view.addSubview(newsTableView)
        
        setSupportBtn()
    }
    
    
    func setSupportBtn() {
        //サポート
        supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        supportBtn.setImage(UIImage(named:"support_sample"), for: UIControlState.normal)
        supportBtn.imageView?.contentMode = .scaleAspectFit
        supportBtn.contentHorizontalAlignment = .fill
        supportBtn.contentVerticalAlignment = .fill
        supportBtn.backgroundColor = UIColor.clear
        supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
        self.view.addSubview(supportBtn)
    }
    
    //MARK: ButtonActions
    func supportBtnClicked(sender: UIButton){
        supportBtn.removeFromSuperview()
    }
    
    func getNews() {
        
        Alamofire.request(API_URL+API_VERSION+ZOO_NEWS).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                //print(json)
                print(json["is_success"].stringValue)
                print(json["content"].arrayValue)
                self.newsContents = json["content"]
                
                self.newsTableView.reloadData()
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
        
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return self.newsContents.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell
        
        var dateText:String = self.newsContents[indexPath.row]["posted_at"].stringValue
        dateText = dateText.substring(to: dateText.index(dateText.startIndex, offsetBy: 10))
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.newsContents[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.newsContents[indexPath.row]["content"].stringValue
        let imageUrl = URL(string:self.newsContents[indexPath.row]["image_url"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        //デリゲートを用いて初めのViewの色をランダムに変える
        delegate?.openNews(newsUrl: self.newsContents[indexPath.row]["article_url"].stringValue)
    }
}
