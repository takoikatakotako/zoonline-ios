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
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!

    
    //テーブルビューインスタンス
    private var myPageTableView: UITableView!
    
    let ARRAY_MYPAGE_SCTION_TITLE: NSArray = ["ユーザー情報", "設定・その他", "ログアウト"]
    
    let userInfoThumbnails:NSArray = [UIImage(named:"mypage_post")!, UIImage(named:"mypage_friends")!,UIImage(named:"mypage_follower")!, UIImage(named:"mypage_favorite")!]
    let ARRAY_MYPAGE_USER_INFOS: NSArray = ["投稿","フレンズ", "フォロワー", "お気に入り"]

    let configThumbnails:NSArray = [UIImage(named:"mypage_contact")!, UIImage(named:"mypage_share")!]
    let ARRAY_MYPAGE_CONFIS: NSArray = ["お問い合わせ","シェア"]

    
    // Sectionで使用する配列を定義する.
    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        let statusBarHeight:CGFloat = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+HEIGHT_USER_CELL + tabBarHeight)
        
        self.view.backgroundColor = UIColor.MyPageTableBGColor()
        
        setNavigationBar()
        
        setUserCellBtn()
        
        setTableView()
    }
    
    // MARK: - Viewにパーツの設置

    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel(frame: CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight))
        titleLabel.text = "マイページ"
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
    
        myPageTableView = UITableView(frame: CGRect(x: 0, y: HEIGHT_USER_CELL, width: viewWidth, height: tableViewHeight),style: UITableViewStyle.grouped)
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
    
    
    //セクションの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }else{
            return 20
        }
    }
    
    //セクションの中身
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //セクション区切りのラベル
        let headerLabel = UILabel()
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        headerLabel.frame = CGRect(x: 0, y: 20, width: 100, height: 20)
    
        return headerLabel
     }
    */
    
    //テーブルに表示する配列の総数を返す.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return ARRAY_MYPAGE_USER_INFOS.count
        } else if section == 1 {
            return ARRAY_MYPAGE_CONFIS.count
        } else if section == 2{
            //ログアウト
            return 1
        }else {
            return 0
        }
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
        } else if indexPath.section == 2{
            cell.textCellLabel.text =  "ログアウト"
            cell.thumbnailImgView.image = UIImage(named:"mypage_logout")
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    //Cellが選択された際に呼び出される.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            //ユーザー情報
            switch indexPath.row {
            case 0:
                //投稿一覧
                let vc:MyPagePostViewController = MyPagePostViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            break
            case 1:
                //フレンズ一覧
                let vc:FriendsListViewController = FriendsListViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                //フォロワー一覧
                let vc:FollowerListViewController = FollowerListViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                //お気に入り
                let vc:MyPageFavoriteViewController = MyPageFavoriteViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
            }
            print("Value: \(ARRAY_MYPAGE_USER_INFOS[indexPath.row])")
        } else if indexPath.section == 1 {
            
            //設定、その他
            switch indexPath.row {
            case 0:
                //contact
                print("Value: \(ARRAY_MYPAGE_CONFIS[indexPath.row])")
                let contactView:WebViewController = WebViewController()
                contactView.url = CONTACT_PAGE_URL_STRING
                contactView.navTitle = "お問い合わせ"
                self.present(contactView, animated: true, completion: nil)
                break
            case 1:
                //ShareBubbles
                break
            default:
                break
            }
        }else if indexPath.section == 2 {
            //login
        
        }else{
        
        
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - アクションの設定
    
    //basicボタンが押されたら呼ばれます
    internal func goMyProfile(sender: UIButton){

        let vc:MyPageProfilelViewController = MyPageProfilelViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
