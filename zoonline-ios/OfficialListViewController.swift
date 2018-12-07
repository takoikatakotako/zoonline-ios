//
//  OfficialListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/09.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

protocol OfficialDelegate: class  {
    func openNews(newsUrl: String)
}

class OfficialListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    //heights
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var statusBarHeight: CGFloat!
    var navigationBarHeight: CGFloat!
    var pageMenuHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    private var tableViewHeight: CGFloat!
    
    //テーブルビューインスタンス
    private var officialTableView: UITableView!
    var indicator: UIActivityIndicatorView!

    var officialContents: JSON = []

    
    //テーブルビューに表示する配列

    weak var delegate: OfficialDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //テーブルビューに表示する配列        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+pageMenuHeight+tabBarHeight)

        setTableView()
        setActivityIndicator()
        indicator.startAnimating()
        
        
        getNews()
    }
    
    
    func setTableView() {
        //テーブルビューの初期化
        officialTableView = UITableView()
        officialTableView.delegate = self
        officialTableView.dataSource = self
        officialTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        officialTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        officialTableView.rowHeight = viewWidth*0.28
        self.view.addSubview(officialTableView)
    }
    
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.3, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.color = UIColor.init(named: "main")
        self.view.addSubview(indicator)
    }
    
    func getNews() {
        
        Alamofire.request(EveryZooAPI.getOfficialNews(), method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                //print("--------------------------")

                //print(response.value)
                
                let json: JSON = JSON(response.result.value ?? kill)

                print(EveryZooAPI.getOfficialNews())
                //print("!-!-!-!-----------------------")
                
                print(json[0])
                

                self.officialContents = json
                
                self.indicator.stopAnimating()
                self.officialTableView.reloadData()
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }

    
    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return self.officialContents.count
    }
    
    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell
        cell.titleLabel.text = officialContents[indexPath.row]["title"]["rendered"].stringValue
        cell.commentLabel.text = UtilityLibrary.removeHtmlTags(text: officialContents[indexPath.row]["excerpt"]["rendered"].stringValue)
        let dateDic = UtilityLibrary.parseDates(text: officialContents[indexPath.row]["date"].stringValue)
        cell.dateLabel.text = dateDic["year"]! + "年"+dateDic["month"]! + "月"+dateDic["day"]! + "日"
        cell.thumbnailImg.image = UIImage(named: "no_img")

        return cell
    }
    
    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.openNews(newsUrl: officialContents[indexPath.row]["link"].stringValue)

    }
}
