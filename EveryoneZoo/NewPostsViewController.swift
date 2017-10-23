//
//  NewPostsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/13.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage

protocol NewPostsDelegate: class  {
    func goDetailView(postID:Int)
    func startIndicator()
    func stopIndicator()
}

class NewPostsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //delegate
    weak var delegate: NewPostsDelegate?
    
    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    var pageMenuHeight:CGFloat!
    var tabBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!

    //view parts
    private var pictureTableView: UITableView!
    
    //APIから取得したデーター
    var imageURLs:Array<String> = Array()
    var postIds:Array<Int> = Array()
    var isNetWorkConnect:Bool = true
    
    //サポートボタン
    let supportBtn:UIButton = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        self.viewWidth = self.view.frame.width
        self.viewHeight = self.view.frame.height
        self.tableViewHeight = viewHeight - (statusBarHeight + navigationBarHeight + pageMenuHeight + tabBarHeight)

        setTableView()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let didSupport:Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_Field"))!
        if !didSupport {
            setSupportBtn()
        }
        
        //network
        dowonloadJsons()
        
        self.delegate?.startIndicator()

    }

    func setSupportBtn() {
        //サポート
        supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        supportBtn.setImage(UIImage(named:"support_plaza"), for: UIControlState.normal)
        supportBtn.imageView?.contentMode = UIViewContentMode.bottomRight
        supportBtn.contentHorizontalAlignment = .fill
        supportBtn.contentVerticalAlignment = .fill
        supportBtn.backgroundColor = UIColor.clear
        supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
        self.view.addSubview(supportBtn)
    }
    
    func supportBtnClicked(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_Field")
        supportBtn.removeFromSuperview()
    }
    
    
    // MARK: - Viewにパーツの設置
    
    // MARK: テーブルビューの生成
    func setTableView(){
        
        // ScrollViewを生成.
        pictureTableView = UITableView()
        pictureTableView.delegate = self
        pictureTableView.dataSource = self
        pictureTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        pictureTableView.backgroundColor = UIColor.white
        pictureTableView.separatorStyle = .none
        
        // はじめはコンテンツビューのサイズは画面と同じ
        pictureTableView.contentSize = CGSize(width:viewWidth, height:self.tableViewHeight)
        
        //テーブルビューの設置
        pictureTableView.register(LeftPicturesTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(LeftPicturesTableViewCell.self))
        pictureTableView.register(RightPicturesTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(RightPicturesTableViewCell.self))
        pictureTableView.register(NetWorkErrorTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NetWorkErrorTableViewCell.self))
        
        //added
        pictureTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        pictureTableView.rowHeight = viewWidth
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(pictureTableView)
        
        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        pictureTableView.refreshControl = refreshControl
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    // MARK: - TableViewのデリゲートメソッド
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isNetWorkConnect {
            return 1
        }
        return imageURLs.count/6
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //ネットワークエラの処理
        if !isNetWorkConnect {
            let cell:NetWorkErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NetWorkErrorTableViewCell.self), for: indexPath) as! NetWorkErrorTableViewCell
            return cell
        }
        
        if indexPath.row % 2 == 0 {
            //左上に大きい四角があるCell
            let cell:LeftPicturesTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(LeftPicturesTableViewCell.self), for: indexPath) as! LeftPicturesTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            
            for i in 0..<6 {
                let cellNum:Int = indexPath.row*6+i
                let url = URL(string: imageURLs[cellNum])!
                cell.picturesImgViews[i].af_setImage(withURL: url)
                cell.picturesImgViews[i].tag = postIds[cellNum]
                
                //画像にタッチイベントを追加
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))
                singleTap.numberOfTapsRequired = 1
                cell.picturesImgViews[i].addGestureRecognizer(singleTap)
            }
            return cell
        }else{
            //右上に大きい四角があるCell
            let cell:RightPicturesTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(RightPicturesTableViewCell.self), for: indexPath) as! RightPicturesTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            
            for i in 0..<6 {
                
                let cellNum:Int = indexPath.row*6+i
                let url = URL(string: imageURLs[cellNum])!
                cell.picturesImgViews[i].af_setImage(withURL: url)
                cell.picturesImgViews[i].tag = postIds[cellNum]
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))
                singleTap.numberOfTapsRequired = 1
                cell.picturesImgViews[i].addGestureRecognizer(singleTap)
            }
            return cell
        }
    }
    

    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
    
    func dowonloadJsons(){
        
        Alamofire.request(EveryZooAPI.getRecentPosts()).responseJSON{ response in
            
            self.pictureTableView.refreshControl?.endRefreshing()
            self.delegate?.stopIndicator()
            
            switch response.result {
            case .success:
                print("Validation Successful")
                
                self.isNetWorkConnect = true
                let json:JSON = JSON(response.result.value ?? kill)
                self.setImageBtns(json: json)
            case .failure(let error):
                print(error)
                self.isNetWorkConnect = false
                //テーブルの再読み込み
                self.pictureTableView.reloadData()
            }
        }
    }
    
    
    func setImageBtns(json:JSON){
        imageURLs = []
        postIds = []
        for i in 0..<json.count {
            imageURLs.append(json[i]["itemImage"].stringValue)
            postIds.append(json[i]["id"].intValue)
        }
        self.pictureTableView.reloadData()
    }
    
    
    // タッチイベントの検出
    //MARK: シングルタップ時に実行される
    func tapSingle(sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? 400)
        
        //画面遷移を行う
        delegate?.goDetailView(postID: sender.view?.tag ?? 400)
    }
    
    func scrollReflesh(sender : UIRefreshControl) {
        
        self.delegate?.startIndicator()
        dowonloadJsons()
    }
}
