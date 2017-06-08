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
import SDWebImage

class FieldViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
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
    var postIds:Array<Int> = Array()
    var ActivityIndicator: UIActivityIndicatorView!
    var isNetWorkConnect:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //画面横サイズを取得
        self.viewWidth = self.view.frame.width
        self.viewHeight = self.view.frame.height
        self.navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        self.tableViewHeight = viewHeight-(navigationBarHeight+PARTS_HEIGHT_SEGMENT_BAR+PARTS_TABBAR_HEIGHT)
        
        //views
        setNavigationBar()
        setSegmentView()
        setTableView()

        //network
        startActivityIndicator()
        dowonloadJsons()
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let aadView:UIView = UIView()
        aadView.frame = CGRect(x: 0, y: -PARTS_HEIGHT_NAVIGATION_BAR*2, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR*2)
        aadView.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(aadView)
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = NSLocalizedString("KEY_field", comment: "ひろば")
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
        
        serchNavBtn.tintColor = UIColor.white
        serchNavBtn.action = #selector(rightBarBtnClicked(sender:))
    }

    // MARK: セグメントビュー関連
    func setSegmentView(){
        
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
        segmentLeftBtn = UIButton()
        segmentLeftBtn.tag = 0
        segmentLeftBtn.frame = CGRect(x: viewWidth*0.05, y: PARTS_HEIGHT_SEGMENT_BAR*0.05, width: viewWidth*0.45, height: PARTS_HEIGHT_SEGMENT_BAR*0.95)
        segmentLeftBtn.setTitle(NSLocalizedString("KEY_popularity", comment: "人気"), for: UIControlState.normal)
        segmentLeftBtn.addTarget(self, action: #selector(segmentBtnClicked(sender:)), for:.touchUpInside)
        segmentView.addSubview(segmentLeftBtn)
        
        //セグメント左の下線
        leftSegUnderLine = UIView()
        leftSegUnderLine.frame = CGRect(x: viewWidth*0.05, y: PARTS_HEIGHT_SEGMENT_BAR*0.8, width: viewWidth*0.4, height: 2)
        segmentView.addSubview(leftSegUnderLine)
        
        //セグメントビューの右
        segmentRightBtn = UIButton()
        segmentRightBtn.tag = 1
        segmentRightBtn.frame = CGRect(x: viewWidth*0.55, y: PARTS_HEIGHT_SEGMENT_BAR*0.05, width: viewWidth*0.45, height: PARTS_HEIGHT_SEGMENT_BAR*0.95)
        segmentRightBtn.setTitle(NSLocalizedString("KEY_new", comment: "新着"), for: UIControlState.normal)
        segmentRightBtn.addTarget(self, action: #selector(segmentBtnClicked(sender:)), for:.touchUpInside)
        segmentView.addSubview(segmentRightBtn)
        
        //セグメント左の下線
        rightSegUnderLine = UIView()
        rightSegUnderLine.frame = CGRect(x: viewWidth*0.55, y: PARTS_HEIGHT_SEGMENT_BAR*0.8, width: viewWidth*0.4, height: 2)
        segmentView.addSubview(rightSegUnderLine)
        
        //セグメントを左選択状態に
        segmentLeftSelected()
    }
    
    
    // MARK: テーブルビューの生成
    func setTableView(){
        
        // ScrollViewを生成.
        pictureTableView = UITableView()
        pictureTableView.delegate = self
        pictureTableView.dataSource = self
        pictureTableView.frame = CGRect(x: 0, y: PARTS_HEIGHT_SEGMENT_BAR, width: viewWidth, height: self.tableViewHeight)
        pictureTableView.backgroundColor = UIColor.white
        pictureTableView.separatorStyle = .none
        
        // はじめはコンテンツビューのサイズは画面と同じ
        pictureTableView.contentSize = CGSize(width:viewWidth, height:self.tableViewHeight)
        
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
    
    // MARK: - ナビゲーションバーのアクション
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }
    
    internal func rightBarBtnClicked(sender: UIButton){
        print("rightBarBtnClicked")
    }
    

    // MARK: - セグメントバーのアクション
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
            cell.errorImgView.image = UIImage(named: "sample_neterror")!
            return cell
        }
        
        
        //エラーが起こっていない時
        let loadImg = UIImage(named: "sample_loading")!
        
        if indexPath.row % 2 == 0 {
            let cell:LeftPicturesTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(LeftPicturesTableViewCell.self), for: indexPath) as! LeftPicturesTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            
            
            for i in 0..<6 {
                
                let cellNum:Int = indexPath.row*6+i
                let url = URL(string: imageURLs[cellNum])!
                cell.picturesImgs[i].af_setImage(withURL: url, placeholderImage: loadImg)
                cell.picturesImgs[i].isUserInteractionEnabled = true
                cell.picturesImgs[i].tag = postIds[cellNum]
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))  //Swift3
                singleTap.numberOfTapsRequired = 1
                cell.picturesImgs[i].addGestureRecognizer(singleTap)
            }
            return cell
        }else{
            
            let cell:RightPicturesTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(RightPicturesTableViewCell.self), for: indexPath) as! RightPicturesTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            
            for i in 0..<6 {
                
                let cellNum:Int = indexPath.row*6+i
                let url = URL(string: imageURLs[cellNum])!
                cell.picturesImgs[i].af_setImage(withURL: url, placeholderImage: loadImg)
                cell.picturesImgs[i].isUserInteractionEnabled = true
                cell.picturesImgs[i].tag = postIds[cellNum]
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))  //Swift3
                singleTap.numberOfTapsRequired = 1
                cell.picturesImgs[i].addGestureRecognizer(singleTap)
            }
            return cell
        }
    }
    
    // タッチイベントの検出
    //MARK: シングルタップ時に実行される
    func tapSingle(sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? 400)
        
        //ナビゲーションバーの高さを元に戻す
        self.tableViewHeight  = self.viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_SEGMENT_BAR+PARTS_TABBAR_HEIGHT)
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: self.viewWidth, height: self.navigationBarHeight)
        self.segmentView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: PARTS_HEIGHT_SEGMENT_BAR)
        self.pictureTableView.frame = CGRect(x: 0, y: PARTS_HEIGHT_SEGMENT_BAR, width: self.viewWidth, height: self.tableViewHeight)
        
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = sender.view?.tag
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
    

    
    
    // MARK: - TableViewの拡張メソッド
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
                // 上
                self.tableViewHeight = self.viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_SEGMENT_BAR+PARTS_TABBAR_HEIGHT)
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: -self.navigationBarHeight, width: self.viewWidth, height: self.navigationBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: -PARTS_HEIGHT_SEGMENT_BAR, width: self.viewWidth, height: PARTS_HEIGHT_SEGMENT_BAR)
                self.pictureTableView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.tableViewHeight)
            }
        }else{
            animator.addAnimations {
                // 下
                self.tableViewHeight  = self.viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_SEGMENT_BAR+PARTS_TABBAR_HEIGHT)
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: self.viewWidth, height: self.navigationBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: PARTS_HEIGHT_SEGMENT_BAR)
                self.pictureTableView.frame = CGRect(x: 0, y: PARTS_HEIGHT_SEGMENT_BAR, width: self.viewWidth, height: self.tableViewHeight)
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
    
    
    func setImageBtns(json:JSON){
        imageURLs = []
        postIds = []
        for i in 0..<json.count {
            imageURLs.append(json[i]["itemImage"].stringValue)
            postIds.append(json[i]["id"].intValue)
        }
        
        self.pictureTableView.reloadData()
    }
    

    // MARK: - Others
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
