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
    
    //
    var loginedSectionTitle:[String] = ["ユーザー情報", "設定・その他", "ログアウト"]
    var unloginedSectionTitle:[String] = ["設定・その他", "ログアウト"]
    var userInfoTitle:[String] = ["投稿","フレンズ","フォロワー","お気に入り"]
    var userInfoIcon:[String] = ["mypage_post","mypage_friends","mypage_follower","mypage_favorite"]
    var configsTitle:[String] = ["お問い合わせ","シェア"]
    var configsIcon:[String] = ["mypage_contact","mypage_share"]
    var logoutTitle:[String] = ["ログアウト"]
    var logoutIcon:[String] = ["mypage_logout"]
    var loginTitle:[String] = ["ログイン"]
    var loginIcon:[String] = ["mypage_logout"]

    
    // Sectionで使用する配列を定義する.
    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
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
        
        //ログインしている場合はボタンをつける
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            return loginedSectionTitle.count
        }else{
            return unloginedSectionTitle.count
        }
    }
    
    //セクションのタイトルを返す.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //ログインしている場合はボタンをつける
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            return loginedSectionTitle[section]
        }else{
            return unloginedSectionTitle[section]
        }
    }
    
    
    //セクションの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }else{
            return 20
        }
    }
    
    //テーブルに表示する配列の総数を返す.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            switch section {
            case 0:
                return userInfoTitle.count
            case 1:
                return configsTitle.count
            case 2:
                return logoutTitle.count
            default:
                return 0
            }
        }else{
            switch section {
            case 0:
                return configsTitle.count
            case 1:
                return logoutTitle.count
            default:
                return 0
            }
        }
    }
    
    //Cellに値を設定する.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPageTableViewCell.self), for: indexPath) as! MyPageTableViewCell
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            switch indexPath.section {
            case 0:
                cell.textCellLabel.text =  userInfoTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:userInfoIcon[indexPath.row])
            case 1:
                cell.textCellLabel.text =  configsTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:configsIcon[indexPath.row])
            case 2:
                cell.textCellLabel.text =  logoutTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:loginIcon[indexPath.row])
            default: break

            }
        }else{
        
            switch indexPath.section {
            case 0:
                cell.textCellLabel.text =  configsTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:configsIcon[indexPath.row])
            case 1:
                cell.textCellLabel.text =  loginTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:loginIcon[indexPath.row])
            default: break

            }
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    //Cellが選択された際に呼び出される.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            switch indexPath.section {
            case 0:
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
                break
            case 1:
                switch indexPath.row {
                case 0:
                    //お問い合わせ
                    let contactView:WebViewController = WebViewController()
                    contactView.statusBarHeight = self.statusBarHeight
                    contactView.navigationBarHeight = self.navigationBarHeight
                    contactView.url = CONTACT_PAGE_URL_STRING
                    contactView.navTitle = "お問い合わせ"
                    self.present(contactView, animated: true, completion: nil)
                    break
                case 1:
                    //アプリシェア
                    break
                default:
                    break
                }
            case 2:
                //ログアウト
                break
            default: break
                
            }
        }else{
            
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    //お問い合わせ
                    let contactView:WebViewController = WebViewController()
                    contactView.statusBarHeight = self.statusBarHeight
                    contactView.navigationBarHeight = self.navigationBarHeight
                    contactView.url = CONTACT_PAGE_URL_STRING
                    contactView.navTitle = "お問い合わせ"
                    self.present(contactView, animated: true, completion: nil)
                    break
                case 1:
                    //アプリシェア
                    break
                default:
                    break
                }
            case 1:
                //ログイン
                break
            default: break
                
            }
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - アクションの設定
    
    //basicボタンが押されたら呼ばれます
    internal func goMyProfile(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if !(appDelegate.userDefaultsManager?.isLogin())! {

            let loginView:LoginViewController = LoginViewController()
            loginView.statusBarHeight = self.statusBarHeight
            loginView.navigationBarHeight = self.navigationBarHeight
            self.present(loginView, animated: true, completion: nil)
            return
        
        }

        let vc:MyPageProfilelViewController = MyPageProfilelViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
