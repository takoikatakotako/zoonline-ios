//
//  MyPageViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/11.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    
    //テーブルビューインスタンス
    private var myPageTableView: UITableView!
    
    // Sectionで使用する配列を定義する.
    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (PARTS_HEIGHT_STATUS_BAR + PARTS_HEIGHT_NAVIGATION_BAR + HEIGHT_USER_CELL)
        
        
        
        setView()
        
        //user用のセル
        let userCellBtn:MyPageUserCellBtn = MyPageUserCellBtn(frame:CGRect(x: 0, y: (PARTS_HEIGHT_STATUS_BAR + PARTS_HEIGHT_NAVIGATION_BAR), width: viewWidth, height: HEIGHT_USER_CELL))
        userCellBtn.backgroundColor = UIColor.white
        self.view.addSubview(userCellBtn)
        
        
        //table
        myPageTableView = UITableView(frame: CGRect(x: 0, y: (PARTS_HEIGHT_STATUS_BAR + PARTS_HEIGHT_NAVIGATION_BAR + HEIGHT_USER_CELL!), width: viewWidth, height: tableViewHeight))
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.backgroundColor = UIColor.MyPageTableBGColor()
        myPageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MyPageTableViewCell.self))
        myPageTableView.rowHeight = 48
        self.view.addSubview(myPageTableView)
    }

    
    func setView() {
        
        //ステータスバー背景
        let statusBackColor = UIView()
        statusBackColor.frame = CGRect(x: 0, y: 0, width: viewWidth, height: PARTS_HEIGHT_STATUS_BAR)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)
        
        //ナビゲーションバーの作成
        UINavigationBar.appearance().tintColor = UIColor.white
        let myNavBar = UINavigationBar()
        myNavBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
        myNavBar.barTintColor = UIColor.mainAppColor()
        myNavBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let myNavItems = UINavigationItem()
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "マイページ"
        titleLabel.textColor = UIColor.white
        myNavItems.titleView = titleLabel
        

        //作成したNavItemをNavBarに追加する
        myNavBar.pushItem(myNavItems, animated: true)
        self.view.addSubview(myNavBar)
    }
      
    
    
    //セクションの数を返す.
    func numberOfSections(in tableView: UITableView) -> Int {
        return ARRAY_MYPAGE_SCTION_TITLE.count
    }
    
    
    //セクションのタイトルを返す.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ARRAY_MYPAGE_SCTION_TITLE[section] as? String
    }
    
    //Cellが選択された際に呼び出される.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Value: \(ARRAY_MYPAGE_USER_INFOS[indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(ARRAY_MYPAGE_CONFIS[indexPath.row])")
        }
    }
    
    //テーブルに表示する配列の総数を返す.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return ARRAY_MYPAGE_USER_INFOS.count
        } else if section == 1 {
            return ARRAY_MYPAGE_CONFIS.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerFrame = tableView.frame
        
        //セクション区切りのラベル
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 16, y: 5, width: headerFrame.size.width-20, height: 20)
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        
        //区切りラベルを追加する
        let headerView:UIView = UIView(frame: CGRect(x:0, y:0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.addSubview(headerLabel)
        
        return headerView

    }
    
    //Cellに値を設定する.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPageTableViewCell.self), for: indexPath) as! MyPageTableViewCell
        
        
        if indexPath.section == 0 {
          //  cell.textLabel?.text = "\(ARRAY_MYPAGE_USER_INFOS[indexPath.row])"
        } else if indexPath.section == 1 {
          //  cell.textLabel?.text = "\(ARRAY_MYPAGE_CONFIS[indexPath.row])"
        }
        
       // cell.imageView?.image = UIImage(named: "sample_kabi1")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }


    
}
