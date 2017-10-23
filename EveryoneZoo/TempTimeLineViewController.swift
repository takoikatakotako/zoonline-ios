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
    private var timeLineTableView:UITableView = UITableView()
    
    private var isNetWorkConnect:Bool!


    //Contents
    var newsContents:JSON = []

    var indicator: UIActivityIndicatorView!
    
    //サポートボタン
    let supportBtn:UIButton = UIButton()
    
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
        
        isNetWorkConnect = true
        
        setNavigationBarBar()
        setTableView()
        setActivityIndicator()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refleshTableView()
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: くるくるの生成
    func setActivityIndicator(){
        
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.4, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.color = UIColor.MainAppColor()
        self.view.addSubview(indicator)
    }
    
    // MARK: NavigationBarの設置
    func setNavigationBarBar(){

        //UINavigationBarの位置とサイズを指定
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "タイムライン"
    }
    
    func setTableView() {
        
        //テーブルビューの初期化
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        timeLineTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        timeLineTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        timeLineTableView.register(NoLoginTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NoLoginTableViewCell.self))
        timeLineTableView.register(NetWorkErrorTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NetWorkErrorTableViewCell.self))
        timeLineTableView.rowHeight = viewWidth*0.28
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
            self.indicator.stopAnimating()
            self.timeLineTableView.reloadData()
        }
    }


    
    func setSupportBtn() {
        //サポート
        supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        supportBtn.setImage(UIImage(named:"support_timeline"), for: UIControlState.normal)
        supportBtn.imageView?.contentMode = UIViewContentMode.bottomRight
        supportBtn.contentHorizontalAlignment = .fill
        supportBtn.contentVerticalAlignment = .fill
        supportBtn.backgroundColor = UIColor.clear
        supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
        self.view.addSubview(supportBtn)
    }

    func supportBtnClicked(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_TimeLine")
        supportBtn.removeFromSuperview()
    }
    
    func scrollReflesh(sender : UIRefreshControl) {
        self.timeLineTableView.refreshControl?.endRefreshing()
        
        refleshTableView()
    }
    
    func refleshTableView() {
        
        if !UtilityLibrary.isLogin() {
            timeLineTableView.reloadData()
        }else{
            self.indicator.startAnimating()
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
        
        return viewWidth*0.28
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !UtilityLibrary.isLogin() {
            let cell:NoLoginTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NoLoginTableViewCell.self), for: indexPath) as! NoLoginTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.loginBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
            return cell
        }
        
        if !isNetWorkConnect {
            let cell:NetWorkErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NetWorkErrorTableViewCell.self), for: indexPath) as! NetWorkErrorTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        
        //myItems配列の中身をテキストにして登録した
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell

        var dateText:String = self.newsContents[indexPath.row]["updated_at"].stringValue
        dateText = dateText.substring(to: dateText.index(dateText.startIndex, offsetBy: 10))
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.newsContents[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.newsContents[indexPath.row]["caption"].stringValue
        let imageUrl = URL(string:self.newsContents[indexPath.row]["itemImage"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl)
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !UtilityLibrary.isLogin() {
            return
        }
        
        if !isNetWorkConnect {
            return
        }
        
        goDetailView(postID: self.newsContents[indexPath.row]["id"].intValue)
    }
    
    func goDetailView(postID:Int) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = postID
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
    
    
    //Mark: 未ログイン関係の処理
    
    //ログインボタンが押されたら呼ばれます
    func loginBtnClicked(sender: UIButton){
        
        let loginView:LoginViewController = LoginViewController()
        loginView.statusBarHeight = self.statusBarHeight
        loginView.navigationBarHeight = self.navigationBarHeight
        self.present(loginView, animated: true, completion: nil)
    }
    
    //登録ボタンが押されたら呼ばれます
    func resistBtnClicked(sender: UIButton){
        
        let resistView:NewResistViewController = NewResistViewController()
        self.present(resistView, animated: true, completion: nil)
    }
}
