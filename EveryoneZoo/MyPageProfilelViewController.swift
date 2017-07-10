//
//  MyPageProfilelViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/18.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MyPageProfilelViewController: UIViewController,UITableViewDelegate, UITableViewDataSource   {

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var myProfielViewHeight:CGFloat!
    private var userConfigTableViewHeight:CGFloat!

    
    //テーブルビューインスタンス
    var userConfigTableView: UITableView!
    
    //表示するもの
    let changeUserInfoAry:Array<String> = ["ユーザー名","自己紹介","メールアドレス","パスワードの変更"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        myProfielViewHeight = viewWidth*0.56
        userConfigTableViewHeight = viewHeight - (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR+myProfielViewHeight+PARTS_TABBAR_HEIGHT)
        setNavigationBar()
        
        self.view.backgroundColor = UIColor.white

        //自分の情報
        let myProfielView:UIView = UIView()
        myProfielView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*0.56)
        //myProfielView.backgroundColor = UIColor.gray
        self.view.addSubview(myProfielView)

        //卵アイコン
        let iconBaseBtn:UIButton = UIButton()
        let iconBaseBtnHeight:CGFloat = myProfielView.frame.height*0.44
        iconBaseBtn.frame =  CGRect(x: viewWidth/2-iconBaseBtnHeight/2, y: myProfielView.frame.height*0.1, width: iconBaseBtnHeight, height:iconBaseBtnHeight)
        iconBaseBtn.layer.cornerRadius = iconBaseBtnHeight/2
        iconBaseBtn.layer.masksToBounds = true
        iconBaseBtn.setBackgroundImage(UIImage(named:"sample_kabi1"), for: UIControlState.normal)
        myProfielView.addSubview(iconBaseBtn)
        
        // 名前
        let nameLabel:UILabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y:  myProfielView.frame.height*0.6, width: viewWidth, height:myProfielView.frame.height*0.2)
        nameLabel.text = "道券カビゴン"
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 28)
        self.view.addSubview(nameLabel)
        
        // Mail
        let mailLabel:UILabel = UILabel()
        mailLabel.frame = CGRect(x: 0, y:  myProfielView.frame.height*0.75, width: viewWidth, height:myProfielView.frame.height*0.2)
        mailLabel.text = "d.uiji.snorlax.love.grass@gmail.com"
        mailLabel.textAlignment = NSTextAlignment.center
        mailLabel.font = UIFont.systemFont(ofSize: 14)
        mailLabel.textColor = UIColor.gray
        self.view.addSubview(mailLabel)
        
        
        //テーブルビューの初期化
        userConfigTableView = UITableView(frame: CGRect(x: 0, y:(viewWidth*0.56), width: viewWidth, height: userConfigTableViewHeight),style: UITableViewStyle.grouped)
        userConfigTableView.delegate = self
        userConfigTableView.dataSource = self
        //userConfigTableView.frame = CGRect(x: 0, y:(viewWidth*0.56), width: viewWidth, height: userConfigTableViewHeight)
        userConfigTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(userConfigTableView)
        
    }

    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    //セクションの数を返す.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
     //セクションのタイトルを返す.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        if section == 0 {
            return 1
        }else{
            return changeUserInfoAry.count
        }
    }
    
    
    //セクションの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell

        if indexPath.section == 0{
            cell.textLabel?.text = "プロフィールのプレビュー"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: (cell.textLabel?.font.pointSize)!)
            cell.textLabel?.textColor = UIColor.mainAppColor()
        }else{
            cell.textLabel?.text = changeUserInfoAry[indexPath.row]
        }
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        let vc:ProfielViewController = ProfielViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
