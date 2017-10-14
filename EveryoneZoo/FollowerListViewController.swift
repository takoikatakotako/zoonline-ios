//
//  FollowerListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/06.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import SCLAlertView

class FollowerListViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var userID:Int!
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!

    //テーブルビューインスタンス
    var followerCollectionView : UICollectionView!
    private var followerList:JSON = []
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+tabBarHeight)
        
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        
        //テーブルビューの初期化
        setCollectionView()
        
        setActivityIndicator()
        
        indicator.startAnimating()
        
        getMyFriends()
    }

    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.MainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "フォロワー"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    func setCollectionView() {
        //テーブルビューの初期化
        let collectionFrame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:viewWidth/3, height:viewWidth/3)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.headerReferenceSize = CGSize(width:0,height:0)
        followerCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        followerCollectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UserCollectionViewCell.self))
        followerCollectionView.delegate = self
        followerCollectionView.dataSource = self
        followerCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(followerCollectionView)
    }
    
    func setActivityIndicator(){
        
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.25, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.clipsToBounds = true
        indicator.layer.cornerRadius = viewWidth*0.3*0.3
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = UIColor.MainAppColor()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.bringSubview(toFront: indicator)
        indicator.color = UIColor.white
        self.view.addSubview(indicator)
    }
    
    
    func getMyFriends() {
        
        Alamofire.request(EveryZooAPI.getFollower(userID: userID)).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                
                if json["is_success"].boolValue {
                    self.followerList = json["responce"]
                    self.indicator.stopAnimating()
                    self.followerCollectionView.reloadData()
                }else{
                    //エラー
                    SCLAlertView().showInfo("エラー", subTitle: "フレンズの取得に失敗しました。")
                }
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
    
    //MARK: テーブルビューのセルの数を設定する
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        
        //画面遷移、ユーザー情報画面へ
        let userInfoView: UserInfoViewController = UserInfoViewController()
        userInfoView.postUserID = followerList[indexPath.row]["user-id"].intValue
        
        let btn_back = UIBarButtonItem()
        btn_back.title = ""
        self.navigationItem.backBarButtonItem = btn_back
        self.navigationController?.pushViewController(userInfoView, animated: true)
    }
    
    //Cellの総数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return frindsList.count
        return followerList.count
    }
    
    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UserCollectionViewCell.self), for: indexPath) as! UserCollectionViewCell
        cell.userLabel?.textColor = UIColor.black
        cell.userLabel!.text = followerList[indexPath.row]["user-name"].stringValue
        
        if let url = URL(string:followerList[indexPath.row]["icon-url"].stringValue) {
            cell.icomImageView.af_setImage(withURL: url)
        }
        
        return cell
    }
}
