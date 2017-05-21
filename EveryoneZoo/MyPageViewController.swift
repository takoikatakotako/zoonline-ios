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
    
    let userInfoThumbnails:NSArray = [UIImage(named:"mypage_post_icon")!, UIImage(named:"mypage_follow_icon")!,UIImage(named:"mypage_favo_icon")!, UIImage(named:"mypage_clip_icon")!]
    let configThumbnails:NSArray = [UIImage(named:"mypage_notification_icon")!, UIImage(named:"mypage_share_icon")!,UIImage(named:"tab_kabi")!]
    
    // Sectionで使用する配列を定義する.
    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (HEIGHT_USER_CELL + PARTS_TABBAR_HEIGHT)
        
        setNavigationBar()
        
        setUserCellBtn()
        
        setTableView()
    }
    
    // MARK: - Viewにパーツの設置

    // MARK: ステータスバー背景
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "マイページ"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }

    //user用のセル
    func setUserCellBtn() {
        
        let userCellBtn:MyPageUserCellBtn = MyPageUserCellBtn(frame:CGRect(x: 0, y: 0, width: viewWidth, height: HEIGHT_USER_CELL))
        userCellBtn.backgroundColor = UIColor.white
        userCellBtn.addTarget(self, action: #selector(MyPageViewController.goMyProfile(sender:)), for:.touchUpInside)
        self.view.addSubview(userCellBtn)
    }
    
    //TableViewの設置
    func setTableView(){
    
        myPageTableView = UITableView(frame: CGRect(x: 0, y: HEIGHT_USER_CELL, width: viewWidth, height: tableViewHeight))
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.backgroundColor = UIColor.MyPageTableBGColor()
        myPageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MyPageTableViewCell.self))
        myPageTableView.rowHeight = 48
        self.view.addSubview(myPageTableView)
    }
    
    // MARK: - TableViewのデリゲートメソッド
    
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
            
            switch indexPath.row {
            case 0:
                let vc:MyPagePostViewController = MyPagePostViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            break
            case 1:
                let vc:MyPageFollowViewController = MyPageFollowViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                let vc:MyPageFavoriteViewController = MyPageFavoriteViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
                
            }
            
            print("Value: \(ARRAY_MYPAGE_USER_INFOS[indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(ARRAY_MYPAGE_CONFIS[indexPath.row])")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
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
       // headerView.backgroundColor = UIColor.red
        
        return headerView

    }
    
    //Cellに値を設定する.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPageTableViewCell.self), for: indexPath) as! MyPageTableViewCell
        
        
        if indexPath.section == 0 {
          //  cell.textLabel?.text = "\(ARRAY_MYPAGE_USER_INFOS[indexPath.row])"
            cell.textCellLabel.text =  "\(ARRAY_MYPAGE_USER_INFOS[indexPath.row])"
            cell.thumbnailImgView.image = userInfoThumbnails[indexPath.row] as? UIImage
        } else if indexPath.section == 1 {
          //  cell.textLabel?.text = "\(ARRAY_MYPAGE_CONFIS[indexPath.row])"
            cell.textCellLabel.text =  "\(ARRAY_MYPAGE_CONFIS[indexPath.row])"

            cell.thumbnailImgView.image = configThumbnails[indexPath.row] as? UIImage
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    // MARK: - アクションの設定
    
    //basicボタンが押されたら呼ばれます
    internal func goMyProfile(sender: UIButton){

        let vc:MyPageProfilelViewController = MyPageProfilelViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
