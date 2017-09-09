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
    private var myTableView: UITableView!
    
    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    
    //UserInfo
    //ユーザーIDとユーザー名は受け取る
    var postUserID:Int!
    
    var userInfos:JSON = []
    var userName:String = ""
    var userProfile:String = ""
    var userIconUrl:String = ""
    var postsInfos:JSON = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        self.view.backgroundColor = UIColor.white
    
        setNavigationBar()
        
        
        getUserInfo()
        getPosts()
        
        //テーブルビューに表示する配列
        self.setTableView()

    }
    
    func getUserInfo() {
        //ユーザーの情報を取得する
        Alamofire.request(API_URL+API_VERSION+USERS+String(postUserID)).responseJSON{ response in
            
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
                
                self.setProfileView()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getPosts() {
        
        Alamofire.request(API_URL+API_VERSION+USERS+String(postUserID)+SLASH+POSTS).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)

                print(json)
                self.postsInfos = json
                self.myTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
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
    
    
    func setProfileView() {
        
        //
        let profileView:UIView = UIView()
        profileView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*0.65)
        profileView.backgroundColor = UIColor.lightGray
        self.view.addSubview(profileView)
        
        let profileIconViewWidth:CGFloat = viewWidth*0.24
        let profileIcon:UIImageView = UIImageView()
        profileIcon.frame = CGRect(x: viewWidth/2-profileIconViewWidth/2, y: viewWidth*0.65*0.1, width: profileIconViewWidth, height: profileIconViewWidth)
        
        if self.userIconUrl.isEmpty {
            profileIcon.image = UIImage(named:"icon_default")

        }else{
            profileIcon.sd_setImage(with: URL(string:self.userIconUrl), placeholderImage: UIImage(named: "sample_loading"))
        }
        self.view.addSubview(profileIcon)
        
        let profileName:UILabel = UILabel()
        profileName.text = self.userName
        profileName.frame = CGRect(x: 0, y: viewWidth*0.65*0.5, width: viewWidth, height: 40)
        profileName.textAlignment = NSTextAlignment.center
        profileName.font = UIFont.systemFont(ofSize: 26)
        self.view.addSubview(profileName)
        
        let profileText:UILabel = UILabel()
        profileText.text = self.userProfile
        profileText.frame = CGRect(x: viewWidth*0.05, y: viewWidth*0.65*0.6, width: viewWidth*0.9, height: viewWidth*0.65*0.4)
        profileText.numberOfLines = 0
        profileText.textAlignment = NSTextAlignment.center
        profileText.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(profileText)
    }
    
    
    func setTableView() {
        //テーブルビューの初期化
        myTableView = UITableView()
        
        //デリゲートの設定
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //テーブルビューの大きさの指定
        myTableView.frame = CGRect(x: 0, y: viewWidth*0.65, width: viewWidth, height: viewHeight-viewWidth*0.65-(statusBarHeight+tabBarHeight+navigationBarHeight))
        
        //テーブルビューの設置
        myTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        myTableView.rowHeight = viewWidth*0.28
        self.view.addSubview(myTableView)
    }
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print(self.postsInfos.count)
        
        return self.postsInfos.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell
        
        var dateText:String = self.postsInfos[indexPath.row]["updated_at"].stringValue
        dateText = dateText.substring(to: dateText.index(dateText.startIndex, offsetBy: 10))
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.postsInfos[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.postsInfos[indexPath.row]["caption"].stringValue
        let imageUrl = URL(string:self.postsInfos[indexPath.row]["image_url"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = self.postsInfos[indexPath.row]["id"].intValue
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
