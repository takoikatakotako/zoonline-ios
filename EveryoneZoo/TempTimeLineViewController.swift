//
//  TempPictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/20.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class TempTimeLineViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!

    private var timeLineTableView: UITableView!

    var newsContents:JSON = []


    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+tabBarHeight!)
        
        setNavigationBarBar()
        
        
        
        //テーブルビューの初期化
        timeLineTableView = UITableView()
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        timeLineTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        timeLineTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        timeLineTableView.rowHeight = viewWidth*0.28
        self.view.addSubview(timeLineTableView)
        
        getNews()
    }

    
    func getNews() {
        
        Alamofire.request(APP_URL+GET_USER_INFO + "1" + FOLLOWING_POSTS).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                
                if json["is_success"].boolValue {
                    print(json["content"].arrayValue)
                    self.newsContents = json["content"]
                    
                    self.timeLineTableView.reloadData()
                }
  
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }

    // MARK: - Viewにパーツの設置
    // MARK: NavigationBarの設置
    func setNavigationBarBar(){
        
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        //UINavigationBarの位置とサイズを指定
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "タイムライン"
    }
    

    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return newsContents.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell

        cell.titleLabel.text = self.newsContents[indexPath.row]["title"].stringValue
        
        var dateText:String = self.newsContents[indexPath.row]["updated_at"].stringValue
        dateText = dateText.substring(to: dateText.index(dateText.startIndex, offsetBy: 10))
        
        
        cell.dateLabel.text = dateText
        cell.commentLabel.text = self.newsContents[indexPath.row]["caption"].stringValue
        let imageUrl = URL(string:self.newsContents[indexPath.row]["itemImage"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))

        
        
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        //デリゲートを用いて初めのViewの色をランダムに変える
        goDetailView(postID: self.newsContents[indexPath.row]["id"].intValue)
    }
    func goDetailView(postID:Int) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = postID
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
