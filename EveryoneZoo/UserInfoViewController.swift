//
//  UserInfoViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class UserInfoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    //テーブルビューインスタンス
    private var profileTableView: UITableView!
    
    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var profileCellHeight:CGFloat!
    private var postCellHeight:CGFloat!
    
    //UserInfo
    //ユーザーIDとユーザー名は受け取る
    var postUserID:Int!
    
    var userInfos:JSON = []
    var userName:String = ""
    var userProfile:String = ""
    var userIconUrl:String = ""
    var postsInfos:JSON = []
    
    var indicator: UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()

        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        profileCellHeight = viewWidth*0.65
        postCellHeight = viewWidth*0.28
        
        self.view.backgroundColor = UIColor.white
    
        setNavigationBar()
        setTableView()
        setActivityIndicator()
        indicator.startAnimating()

        getUserInfo()

    }
    
    func getUserInfo() {
        //ユーザーの情報を取得する
        Alamofire.request(EveryZooAPI.getUserInfo(userID: postUserID)).responseJSON{ response in
            
            switch response.result {
            case .success:
            
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                if !json["userName"].stringValue.isEmpty {
                    self.userName = json["userName"].stringValue
                }
                if !json["profile"].stringValue.isEmpty {
                    self.userProfile = json["profile"].stringValue
                }
                if !json["iconUrl"].stringValue.isEmpty {
                    self.userIconUrl = json["iconUrl"].stringValue
                }
                
                self.getPosts()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getPosts() {
        
        Alamofire.request(EveryZooAPI.getUserPosts(userID: postUserID)).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)

                print(json)
                
                self.indicator.stopAnimating()
                if json["is_success"].boolValue {
                    self.postsInfos = json["response"]
                    self.profileTableView.reloadData()
                }else{
                    //不明なエラー
                }

                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.MainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }
    
    
    func setTableView() {
        //テーブルビューの初期化
        profileTableView = UITableView()
        
        //デリゲートの設定
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        //テーブルビューの大きさの指定
        profileTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight-(statusBarHeight+tabBarHeight+navigationBarHeight))
        
        //テーブルビューの設置
        profileTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        profileTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UserInfoTableViewCell.self))
        self.view.addSubview(profileTableView)
    }
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.4-44, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.bringSubview(toFront: indicator)
        indicator.color = UIColor.MainAppColor()
        self.view.addSubview(indicator)
    }
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.postsInfos.count+1
    }
    
    //MARK: テーブルビューのセルの高さを計算する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {

            return profileCellHeight
        }else {
            return postCellHeight
        }
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        
        if indexPath.row == 0 {
            let cell:UserInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserInfoTableViewCell.self), for: indexPath) as! UserInfoTableViewCell
            cell.backgroundColor = UIColor.MypageArrowGray()
            cell.iconImgView.sd_setImage(with: URL(string:self.userIconUrl), placeholderImage: UIImage(named: "icon_default"))
            cell.userNameLabel.text = self.userName
            cell.profileLabel.text = self.userProfile
            return cell
        }
        
        
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell
        
        if self.postsInfos.count == 0 {
            return cell
        }
        
        var dateText:String = self.postsInfos[indexPath.row-1]["updated_at"].stringValue
        
        dateText = dateText.substring(to: dateText.index(dateText.startIndex, offsetBy: 10))
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.postsInfos[indexPath.row-1]["title"].stringValue
        cell.commentLabel.text = self.postsInfos[indexPath.row-1]["caption"].stringValue
        let imageUrl = URL(string:self.postsInfos[indexPath.row-1]["image_url"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        if indexPath.row == 0 {
            return
        }
        
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = self.postsInfos[indexPath.row-1]["id"].intValue
        
        let btn_back = UIBarButtonItem()
        btn_back.title = ""
        self.navigationItem.backBarButtonItem = btn_back
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
