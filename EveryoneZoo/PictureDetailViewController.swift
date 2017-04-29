//
//  PictureDetailViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    //width, height
    private var statusHeight:CGFloat!
    private var navBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    
    //view parts
    private var postDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画面横サイズを取得
        let viewWidth:CGFloat = self.view.frame.width
        let viewHeight:CGFloat  = self.view.frame.height
        
        //各部品の高さを取得
        
        statusHeight = UIApplication.shared.statusBarFrame.height
        navBarHeight =  self.navigationController?.navigationBar.frame.height
        tabBarHeight = 50
        tableViewHeight = viewHeight-(statusHeight+navBarHeight+tabBarHeight)
        
        setView()

        
        //テーブルビューの初期化
        postDetailTableView = UITableView()
        
        //デリゲートの設定
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        
        //テーブルビューの大きさの指定
        postDetailTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        
        //テーブルビューの設置
        postDetailTableView.register(PostDetailTableCell.self, forCellReuseIdentifier: NSStringFromClass(PostDetailTableCell.self))
        postDetailTableView.rowHeight = viewWidth*1.65
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(postDetailTableView)
        
    }
    
    //Viewへの配置
    func setView() {
        
        //背景色を変更
        self.view.backgroundColor = UIColor.mainAppColor()
        
        // MARK: - UINavigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        
        //ハイライトを消す
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションボタンの色を変更する
        UINavigationBar.appearance().tintColor = UIColor.white
    }

    //左側のボタンが押されたら呼ばれる
    func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
        self.dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return 1
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:PostDetailTableCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostDetailTableCell.self), for: indexPath) as! PostDetailTableCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.menuBtn.addTarget(self, action: #selector(showActionShert(sender:)), for:.touchUpInside)

        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
    
    //Mark: コメント投稿画面への遷移
    func showActionShert(sender: UIButton){
        // インスタンス生成　styleはActionSheet.
        let myAlert = UIAlertController(title: "アクション", message: "アクションを選んでください。", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // アクションを生成.
        let myAction_1 = UIAlertAction(title: "コメント", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("Hello")
            // 移動先のViewを定義する.
            let commentListlView: CommentListViewController = CommentListViewController()
            // SecondViewに移動する.
            self.navigationController?.pushViewController(commentListlView, animated: true)
        })
        
        let myAction_2 = UIAlertAction(title: "共有する", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("yes")
        })
        
        let myAction_3 = UIAlertAction(title: "マイアルバムへの追加", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("no")
        })
        
        // アクションを追加.
        myAlert.addAction(myAction_1)
        myAlert.addAction(myAction_2)
        myAlert.addAction(myAction_3)
        
        self.present(myAlert, animated: true, completion: nil)
    }


}
