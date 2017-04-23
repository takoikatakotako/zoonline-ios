//
//  PictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/17.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import AlamofireImage
import SwiftyJSON

class PictureViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    //width, height
    private var statusHeight:CGFloat!
    private var navBarHeight:CGFloat!
    private var segmentViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    
    //view parts
    private var pictureTableView: UITableView!
    @IBOutlet weak var serchNavBtn: UIBarButtonItem!
    
    //segment view parts
    private var segmentView:UIView!
    private var segmentLeftBtn:UIButton!
    private var leftSegUnderLine:UIView!
    private var segmentRightBtn:UIButton!
    private var rightSegUnderLine:UIView!
    
    //APIから取得したデーター
    var imageURLs:Array<String> = Array()
    var ActivityIndicator: UIActivityIndicatorView!
    var isNetWorkConnect:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcHeight()
        
        //views
        setView()
        setSegmentView()
        setTableView()

        //network
        startActivityIndicator()
        dowonloadJsons()
    }
    
    // MARK: - ClalcHeight
    func calcHeight(){
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //各部品の高さを取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        navBarHeight =  self.navigationController?.navigationBar.frame.height
        segmentViewHeight = self.navigationController?.navigationBar.frame.height
        tabBarHeight = UITabBar.appearance().frame.size.height
        tableViewHeight = viewHeight-(statusHeight+navBarHeight+segmentViewHeight+tabBarHeight+tabBarHeight)
    }

    // MARK: - View関連
    func setView() {
        
        self.view.backgroundColor = UIColor.mainAppColor()
        
        //ステータスバー部分の背景
        let statusBackColor = UIView()
        statusBackColor.frame = CGRect(x: 0, y: -(statusHeight+navBarHeight), width: viewWidth, height: navBarHeight*2)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)
        
        // MARK: - UINavigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = NSLocalizedString("KEY_field", comment: "ひろば")

        serchNavBtn.tintColor = UIColor.white
        serchNavBtn.action = #selector(rightBarBtnClicked(sender:))
    }
    
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }
    
    internal func rightBarBtnClicked(sender: UIButton){
        print("rightBarBtnClicked")
        
    }
    
    // MARK: - セグメントビュー関連
    func setSegmentView(){
        
        // MARK: - segmentView
        segmentView = UIView()
        segmentView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: segmentViewHeight)
        segmentView.backgroundColor = UIColor.white
        self.view.addSubview(segmentView)
        
        //スクロールビューとの区切り線
        let segmentLine = UIView()
        segmentLine.frame = CGRect(x: 0, y: segmentViewHeight - 2, width: viewWidth, height: 2)
        segmentLine.backgroundColor = UIColor.gray
        segmentView.addSubview(segmentLine)
        
        //セグメントビューの左
        segmentLeftBtn = UIButton()
        segmentLeftBtn.tag = 0
        segmentLeftBtn.frame = CGRect(x: viewWidth*0.05, y: segmentViewHeight*0.1, width: viewWidth*0.4, height: segmentViewHeight*0.7)
        segmentLeftBtn.setTitle(NSLocalizedString("KEY_popularity", comment: "人気"), for: UIControlState.normal)
        segmentLeftBtn.addTarget(self, action: #selector(segmentBtnClicked(sender:)), for:.touchUpInside)
        segmentView.addSubview(segmentLeftBtn)
        
        //セグメント左の下線
        leftSegUnderLine = UIView()
        leftSegUnderLine.frame = CGRect(x: viewWidth*0.05, y: segmentViewHeight*0.8, width: viewWidth*0.4, height: 2)
        segmentView.addSubview(leftSegUnderLine)
        
        //セグメントビューの右
        segmentRightBtn = UIButton()
        segmentRightBtn.tag = 1
        segmentRightBtn.frame = CGRect(x: viewWidth*0.55, y: segmentViewHeight*0.1, width: viewWidth*0.4, height: segmentViewHeight*0.7)
        segmentRightBtn.setTitle(NSLocalizedString("KEY_new", comment: "新着"), for: UIControlState.normal)
        segmentRightBtn.addTarget(self, action: #selector(segmentBtnClicked(sender:)), for:.touchUpInside)
        segmentView.addSubview(segmentRightBtn)
        
        //セグメント左の下線
        rightSegUnderLine = UIView()
        rightSegUnderLine.frame = CGRect(x: viewWidth*0.55, y: segmentViewHeight*0.8, width: viewWidth*0.4, height: 2)
        segmentView.addSubview(rightSegUnderLine)
        
        //セグメントを左選択状態に
        segmentLeftSelected()
    }

    
    //セグメントの切り替えが呼ばれた呼ばれる
    func segmentBtnClicked(sender: UIButton){

        switch sender.tag {
        case 0:
            //左側が押された
            segmentLeftSelected()
            
            break
        case 1:
            //右側が押された
            segmentRightSelected()
            
            break
        default:
            break // do nothing
        }
    }
    
    //左側が押されてる
    func segmentLeftSelected(){
    
        //色を変更する
        segmentLeftBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        leftSegUnderLine.backgroundColor = UIColor.segmetRightBlue()
        
        segmentRightBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        rightSegUnderLine.backgroundColor = UIColor.white
        
    }
    
    //右側が押されてる
    func segmentRightSelected(){
        
        //色を変更する
        segmentRightBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        rightSegUnderLine.backgroundColor = UIColor.segmetRightBlue()
        
        segmentLeftBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        leftSegUnderLine.backgroundColor = UIColor.white
    }
    
    
    // MARK: - テーブリュビューの生成
    func setTableView(){
        
        // ScrollViewを生成.
        pictureTableView = UITableView()
        pictureTableView.delegate = self
        pictureTableView.dataSource = self
        pictureTableView.frame = CGRect(x: 0, y: segmentViewHeight!, width: viewWidth, height: tableViewHeight)
        pictureTableView.backgroundColor = UIColor.white

        // はじめはコンテンツビューのサイズは画面と同じ
        pictureTableView.contentSize = CGSize(width:viewWidth, height:tableViewHeight)
        
        //テーブルビューの設置
        pictureTableView.register(LeftPicturesTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(LeftPicturesTableViewCell.self))
        pictureTableView.register(RightPicturesTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(RightPicturesTableViewCell.self))
        pictureTableView.register(NetWorkErrorTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NetWorkErrorTableViewCell.self))
        pictureTableView.rowHeight = viewWidth
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(pictureTableView)
        
        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        pictureTableView.refreshControl = refreshControl
    }
    
    
    func setImageBtns(json:JSON){
        for i in 0..<json.count {
            imageURLs.append(json[i]["itemImage"].stringValue)
        }
        self.pictureTableView.reloadData()
    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        
        if (velocity.y > 0) {
            // 上下のバーを隠す、上にスライド
            hidesBarsWithScrollView(hidden: true, hiddenTop: true, hiddenBottom: true)
            
        } else {
            // 上下のバーを表示する、下にスライド
            hidesBarsWithScrollView(hidden: false, hiddenTop: true, hiddenBottom: true)
        }
    }
    
    func hidesBarsWithScrollView( hidden:Bool, hiddenTop:Bool, hiddenBottom:Bool) {
        
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 0.2, timingParameters: timing)
        
        if hidden {
            animator.addAnimations {
                // animation
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: -self.navBarHeight, width: self.viewWidth, height: self.navBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: -self.segmentViewHeight, width: self.viewWidth, height: self.segmentViewHeight)
                self.pictureTableView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
            }
        }else{
            animator.addAnimations {
                // animation
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: self.statusHeight, width: self.viewWidth, height: self.navBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.segmentViewHeight)
                self.pictureTableView.frame = CGRect(x: 0, y: self.segmentViewHeight!, width: self.viewWidth, height: self.tableViewHeight)
            }
        }
        animator.startAnimation()
    }
    
    func scrollReflesh(sender : UIRefreshControl) {
        
        //network
        startActivityIndicator()
        dowonloadJsons()
        
        sender.endRefreshing()
    }
    
    internal func pictureSelected(sender: UIButton){
        
        let picDetailView:PictureDetailViewController = PictureDetailViewController()
        navigationController?.pushViewController(picDetailView as UIViewController, animated: true)
    }
    
    // MARK: - NetWork
    func startActivityIndicator(){
        
        // ActivityIndicatorを作成＆中央に配置
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: viewWidth/2-viewWidth*0.1, y: viewHeight*0.2, width: viewWidth*0.1, height: viewWidth*0.1)
        ActivityIndicator.center = self.view.center
        
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        
        // 色を設定
        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        ActivityIndicator.startAnimating()
    }
    
    func dowonloadJsons(){
        
        Alamofire.request(ApiLibrary.getAPIURL()).responseJSON{ response in
            
            
            self.ActivityIndicator.stopAnimating()

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
            cell.errorImgView.image = UIImage(named: "sample_neterror")!
            return cell
        }
        
        if indexPath.row % 2 == 0 {
            let cell:LeftPicturesTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(LeftPicturesTableViewCell.self), for: indexPath) as! LeftPicturesTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            
            let loadImg = UIImage(named: "sample_loading")!
            let url = URL(string: imageURLs[indexPath.row])!
            
            for i in 0..<6 {
                cell.picturesImgs[i].af_setImage(withURL: url, placeholderImage: loadImg)
                cell.picturesImgs[i].isUserInteractionEnabled = true
                cell.picturesImgs[i].tag = indexPath.row*6+i
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))  //Swift3
                singleTap.numberOfTapsRequired = 1
                cell.picturesImgs[i].addGestureRecognizer(singleTap)
            }
            return cell
        }else{
            
            let cell:RightPicturesTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(RightPicturesTableViewCell.self), for: indexPath) as! RightPicturesTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            
            let loadImg = UIImage(named: "sample_loading")!
            let url = URL(string: imageURLs[indexPath.row])!
            
            for i in 0..<6 {
                cell.picturesImgs[i].af_setImage(withURL: url, placeholderImage: loadImg)
                cell.picturesImgs[i].isUserInteractionEnabled = true
                cell.picturesImgs[i].tag = indexPath.row*6+i
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))  //Swift3
                singleTap.numberOfTapsRequired = 1
                cell.picturesImgs[i].addGestureRecognizer(singleTap)
            }
            return cell
        }
    }
    
    // タッチイベントの検出
    /// シングルタップ時に実行される
    func tapSingle(sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? 400)

        // 移動先のViewを定義する.
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        
        // SecondViewに移動する.
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }

    // MARK: - Others
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
