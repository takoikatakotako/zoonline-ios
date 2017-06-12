//
//  TimeLineViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView

class TimeLineViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    //width,height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var tableViewHeight:CGFloat!
    
    //view parts
    private var segmentView:UIView!
    private var postDetailTableView: UITableView!
    private var noLoginView:NoLoginView! = NoLoginView()
    
    // MARK: - OverRideMethod
    override func viewDidLoad() {
        super.viewDidLoad()

        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //スクロルビューの高さ計算
        tableViewHeight = viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR+PARTS_HEIGHT_SEGMENT_BAR+PARTS_TABBAR_HEIGHT)
        
        //Viewにパーツを追加
        setNavigationBarBar()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            setSegmentBar()
            setTableVIew()
        }else{
            setLoginView()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //postDetailTableView.reloadData()
    }
    

    // MARK: - Viewにパーツの設置
    // MARK: NavigationBarの設置
    func setNavigationBarBar(){
        
        //ステータスバー部分の背景
        let statusBackColor = UIView()
        statusBackColor.frame =
            CGRect(x: 0, y: -(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR), width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR*2)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)
        
        //UINavigationBarの位置とサイズを指定
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "タイムライン"
    }

    
    // MARK: SegmentBarの設置
    func setSegmentBar(){
        
        segmentView = UIView()
        segmentView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: PARTS_HEIGHT_SEGMENT_BAR)
        segmentView.backgroundColor = UIColor.white
        self.view.addSubview(segmentView)
        
        //スクロールビューとの区切り線
        let segmentLine = UIView()
        segmentLine.frame = CGRect(x: 0, y: PARTS_HEIGHT_SEGMENT_BAR - 2, width: viewWidth, height: 2)
        segmentLine.backgroundColor = UIColor.gray
        segmentView.addSubview(segmentLine)
        
        //セグメントビューの左
        let segmentLeftBtn = UIButton()
        segmentLeftBtn.frame = CGRect(x: viewWidth*0.03, y: PARTS_HEIGHT_SEGMENT_BAR*0.1, width: viewWidth*0.3, height: PARTS_HEIGHT_SEGMENT_BAR*0.7)
        segmentLeftBtn.setTitle("すべて", for: UIControlState.normal)
        segmentLeftBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        //segmentLeftBtn.backgroundColor = UIColor.blue
        segmentView.addSubview(segmentLeftBtn)
        
        //セグメントビューの真ん中
        let segmentCenterBtn = UIButton()
        segmentCenterBtn.frame = CGRect(x: viewWidth*0.36, y: PARTS_HEIGHT_SEGMENT_BAR*0.1, width: viewWidth*0.3, height: PARTS_HEIGHT_SEGMENT_BAR*0.7)
        segmentCenterBtn.setTitle("ユーザー", for: UIControlState.normal)
        segmentCenterBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        segmentView.addSubview(segmentCenterBtn)
        
        //セグメントビューの右
        let segmentRightBtn = UIButton()
        segmentRightBtn.frame = CGRect(x: viewWidth*0.69, y: PARTS_HEIGHT_SEGMENT_BAR*0.1, width: viewWidth*0.3, height: PARTS_HEIGHT_SEGMENT_BAR*0.7)
        segmentRightBtn.setTitle("タグ", for: UIControlState.normal)
        segmentRightBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        //segmentRightBtn.backgroundColor = UIColor.blue
        segmentView.addSubview(segmentRightBtn)
        
        //下線
        let leftUnderBar = UIView()
        leftUnderBar.frame = CGRect(x: viewWidth*0.05, y: PARTS_HEIGHT_SEGMENT_BAR*0.1, width: viewWidth*0.4, height: PARTS_HEIGHT_SEGMENT_BAR*0.7)
        leftUnderBar.backgroundColor = UIColor.segmetRightBlue()
    }
    
    // MARK: TableViewの設置
    func setTableVIew(){
        
        //テーブルビューの初期化
        postDetailTableView = UITableView()
        
        //デリゲートの設定
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        
        //テーブルビューの大きさの指定
        postDetailTableView.frame = CGRect(x: 0, y: PARTS_HEIGHT_SEGMENT_BAR, width: viewWidth, height: tableViewHeight)
        
        //テーブルビューの設置
        postDetailTableView.register(PostDetailTableCell.self, forCellReuseIdentifier: NSStringFromClass(PostDetailTableCell.self))
        postDetailTableView.rowHeight = viewWidth*1.65
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(postDetailTableView)
        
        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        postDetailTableView.refreshControl = refreshControl
    }
    
    // MARK: showLoginView
    func setLoginView()  {
        
        let noLoginViewHeight:CGFloat = viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_TABBAR_HEIGHT)
        noLoginView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: noLoginViewHeight)
        self.view.addSubview(noLoginView)
        
        let loginBtn:UIButton = UIButton()
        loginBtn.frame = CGRect(x: viewWidth*0.2, y: noLoginViewHeight*0.75, width: viewWidth*0.6, height: noLoginViewHeight*0.1)
        loginBtn.setTitle("ログイン", for: UIControlState.normal)
        loginBtn.backgroundColor = UIColor.orange
        self.view.addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
    }
    
    //basicボタンが押されたら呼ばれます
    func loginBtnClicked(sender: UIButton){

        let loginView:LoginViewController = LoginViewController()
        self.present(loginView, animated: true, completion: nil)
    }
    
    // MARK: - TableView関連のメソッド
    //MARK: セルの数の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //MARK: テーブルビューのセルの中身の設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PostDetailTableCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostDetailTableCell.self), for: indexPath) as! PostDetailTableCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
    
    //Mark: テーブルビューがスクロールされた時に呼ばれる
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        
        if (velocity.y > 0) {
            // 上にスクロールされた時
            hidesBarsWithScrollView(hidden: true, hiddenTop: true, hiddenBottom: true)
        } else {
            // 下にスクロールされた時
            hidesBarsWithScrollView(hidden: false, hiddenTop: true, hiddenBottom: true)
        }
    }
    
    //Mark:　ナビゲーションバーを出し入れする
    func hidesBarsWithScrollView( hidden:Bool, hiddenTop:Bool, hiddenBottom:Bool) {
        
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 0.2, timingParameters: timing)
        
        if hidden {
            //ナビゲーションバーを隠す
            self.tableViewHeight = viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_SEGMENT_BAR+PARTS_TABBAR_HEIGHT)
            
            animator.addAnimations {
                // animation
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: -PARTS_HEIGHT_NAVIGATION_BAR, width: self.viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
                self.segmentView.frame = CGRect(x: 0, y: -PARTS_HEIGHT_SEGMENT_BAR, width: self.viewWidth, height: PARTS_HEIGHT_SEGMENT_BAR)
                self.postDetailTableView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.tableViewHeight)
            }
        }else{
            //ナビゲーションバーを出す
            self.tableViewHeight = viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR+PARTS_HEIGHT_SEGMENT_BAR+PARTS_TABBAR_HEIGHT)
            animator.addAnimations {
                // animation
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: self.viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
                self.segmentView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: PARTS_HEIGHT_SEGMENT_BAR)
                self.postDetailTableView.frame = CGRect(x: 0, y: PARTS_HEIGHT_SEGMENT_BAR, width: self.viewWidth, height: self.tableViewHeight)
                
            }
        }
        
        animator.startAnimation()
    }
    
    //Mark:　リフレッシュ更新が走った時に呼ばれる
    func scrollReflesh(sender : UIRefreshControl) {
        
        SCLAlertView().showInfo("スクロールイベントが実行された", subTitle: "close")
        sender.endRefreshing()
    }

    
}
