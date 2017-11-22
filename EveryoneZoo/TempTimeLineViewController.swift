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
import GoogleMobileAds

class TempTimeLineViewController: CustumViewController ,UITableViewDelegate, UITableViewDataSource {
    
    //width, height
    private var tableViewHeight:CGFloat!
    private var timeLineTableView:UITableView = UITableView()
    private var isNetWorkConnect:Bool!
    
    //Contents
    var newsContents:JSON = []

    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageName = PageName.TimeLine.rawValue
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+tabBarHeight!)
        
        isNetWorkConnect = true
        
        setNavigationBarBar(navTitle: "タイムライン")
        setTableView()
        setAd()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refleshTableView()
    }
    
    // MARK: - Viewにパーツの設置
    func setTableView() {
        
        //テーブルビューの初期化
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        timeLineTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        timeLineTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        timeLineTableView.register(NoLoginTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NoLoginTableViewCell.self))
        timeLineTableView.register(NetWorkErrorTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NetWorkErrorTableViewCell.self))
        timeLineTableView.register(BannerAdTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(BannerAdTableViewCell.self))
        timeLineTableView.rowHeight = viewWidth * 0.28
        self.view.addSubview(timeLineTableView)
        
        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: UIControlEvents.valueChanged)
        timeLineTableView.refreshControl = refreshControl
    }
    
    
    // MARK: - インターネット
    func getNews() {
        
        let userID:Int = Int(UtilityLibrary.getUserID())!
        Alamofire.request(EveryZooAPI.getTimeLinePosts(userID: userID)).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                self.isNetWorkConnect = true
                
                if json["is_success"].boolValue {
                    print(json["content"].arrayValue)
                    self.newsContents = json["content"]
                }
                
            case .failure(let error):
                print(error)
                self.newsContents = []
                self.isNetWorkConnect = false
            }
            self.hideIndicator()
            self.timeLineTableView.reloadData()
        }
    }

    func setAd() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - テーブルビュー関連
    func scrollReflesh(sender : UIRefreshControl) {
        self.timeLineTableView.refreshControl?.endRefreshing()
        refleshTableView()
    }
    
    func refleshTableView() {
        
        if !UtilityLibrary.isLogin() {
            timeLineTableView.reloadData()
        }else{
            self.showIndicater()
            getNews()
        }
    }
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if !UtilityLibrary.isLogin() { return 1}
        if !isNetWorkConnect { return 1 }
        
        return newsContents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if !UtilityLibrary.isLogin() { return tableViewHeight }
        if !isNetWorkConnect { return tableViewHeight }
        
        if indexPath.row == 3 || indexPath.row == 8{
            return 50
        }
        
        return viewWidth*0.28
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !UtilityLibrary.isLogin() {
            let cell:NoLoginTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NoLoginTableViewCell.self), for: indexPath) as! NoLoginTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.loginBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
            cell.newResisterBtn.addTarget(self, action: #selector(resistBtnClicked(sender:)), for: .touchUpInside)
            return cell
        }
        
        if !isNetWorkConnect {
            let cell:NetWorkErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NetWorkErrorTableViewCell.self), for: indexPath) as! NetWorkErrorTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        
        if  indexPath.row == 3 || indexPath.row == 8 {
            let cell:BannerAdTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BannerAdTableViewCell.self), for: indexPath) as! BannerAdTableViewCell
            cell.addSubview(bannerView)
            return cell
        }
        
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell
        let dates = UtilityLibrary.parseDates(text: self.newsContents[indexPath.row]["updated_at"].stringValue)
        var dateText:String = dates["year"]! + "/"
        dateText += dates["month"]! + "/" + dates["day"]!
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.newsContents[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.newsContents[indexPath.row]["caption"].stringValue
        let imageUrl = URL(string:self.newsContents[indexPath.row]["itemImage"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl)
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !UtilityLibrary.isLogin() { return }
        if !isNetWorkConnect { return }
        
        goDetailView(postID: self.newsContents[indexPath.row]["id"].intValue)
    }
    
    func goDetailView(postID:Int) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = postID
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
