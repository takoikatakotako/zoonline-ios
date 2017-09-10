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
    private var noLoginView:NoLoginView!


    var newsContents:JSON = []

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
        
        setNavigationBarBar()
        
        noLoginView = NoLoginView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (timeLineTableView.isDescendant(of: self.view)) {
            timeLineTableView.removeFromSuperview()
        }
        
        if (noLoginView.isDescendant(of: self.view)){
            noLoginView.removeFromSuperview()
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            
            //
            setTableView()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let didSupport:Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_TimeLine"))!
            
            if !didSupport {
                setSupportBtn()

            }
            getNews()
            
        }else{
            
            setLoginView()
        }
    }
    
    func getNews() {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userID:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserID"))!
        
        //print(API_URL+API_VERSION+USERS+userID+FOLLOWING+POSTS)
        Alamofire.request(API_URL+API_VERSION+USERS+userID+SLASH+FOLLOWING+POSTS).responseJSON{ response in
            
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
    
    func setTableView() {
        
        //テーブルビューの初期化
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        timeLineTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        timeLineTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        timeLineTableView.rowHeight = viewWidth*0.28
        self.view.addSubview(timeLineTableView)
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

    func supportBtnClicked(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_TimeLine")
        supportBtn.removeFromSuperview()
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

        var dateText:String = self.newsContents[indexPath.row]["updated_at"].stringValue
        dateText = dateText.substring(to: dateText.index(dateText.startIndex, offsetBy: 10))
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.newsContents[indexPath.row]["title"].stringValue
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
    
    
    //Mark: 未ログイン関係の処理
    
    // MARK: setLoginView
    func setLoginView()  {
        
        let noLoginViewHeight:CGFloat = viewHeight-(statusBarHeight+tabBarHeight)
        noLoginView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: noLoginViewHeight)
        noLoginView.loginBtn.addTarget(nil, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
        noLoginView.newResisterBtn.addTarget(self, action: #selector(resistBtnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(noLoginView)
    }
    
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
