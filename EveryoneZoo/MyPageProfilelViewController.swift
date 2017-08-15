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
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    var myProfielViewHeight:CGFloat!
    private var userConfigTableViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!

    
    //テーブルビューインスタンス
    var userConfigTableView: UITableView!
    
    //表示するもの
    let changeUserInfoAry:Array<String> = ["プロフィールのプレビュー","","ユーザー名","自己紹介","メールアドレス","パスワードの変更",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.MyPageTableBGColor()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!

        myProfielViewHeight = viewWidth*0.56
        userConfigTableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+myProfielViewHeight+tabBarHeight)
        
        setNavigationBar()
        
        setProfielView()
        
        setTableView()
    }

    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    // MARK: プロフィールビュー
    func setProfielView() {
        
        //自分の情報
        let myProfielView:UIView = UIView()
        myProfielView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*0.56)
        myProfielView.backgroundColor = UIColor.MyPageTableBGColor()
        self.view.addSubview(myProfielView)
        
        //アイコン選択ボタン
        let iconChoseBtn:UIButton = UIButton()
        let iconChoseBtnHeight:CGFloat = myProfielView.frame.height*0.44
        iconChoseBtn.frame =  CGRect(x: viewWidth/2-iconChoseBtnHeight/2, y: myProfielView.frame.height*0.1, width: iconChoseBtnHeight, height:iconChoseBtnHeight)
        iconChoseBtn.addTarget(self, action: #selector(choseIconBtnClicked(sender:)), for: .touchUpInside)
        //iconChoseBtn.backgroundColor = UIColor.red
        myProfielView.addSubview(iconChoseBtn)
        
        //卵アイコン
        let icon:UIImageView = UIImageView()
        icon.frame = CGRect(x: 0, y: 0, width: iconChoseBtn.frame.size.width, height:iconChoseBtn.frame.size.height)
        icon.layer.cornerRadius = iconChoseBtn.frame.size.width/2
        icon.layer.masksToBounds = true
        icon.isUserInteractionEnabled = false
        icon.image = UIImage(named:"sample_kabi1")
        iconChoseBtn.addSubview(icon)
 
        //プラスのボタン
        let iconPlusImg:UIImageView = UIImageView()
        iconPlusImg.isUserInteractionEnabled = false
        iconPlusImg.frame = CGRect(x: iconChoseBtn.frame.size.width*0.7, y: iconChoseBtn.frame.size.width*0.7, width: iconChoseBtn.frame.size.width*0.3, height:iconChoseBtn.frame.size.height*0.3)
        iconPlusImg.image = UIImage(named:"iconChange")
        iconChoseBtn.addSubview(iconPlusImg)

        // 名前
        let nameLabel:UILabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y:  myProfielView.frame.height*0.58, width: viewWidth, height:myProfielView.frame.height*0.2)
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
    }
    
    func setTableView() {
        
        //テーブルビューの初期化
        userConfigTableView = UITableView()
        userConfigTableView.delegate = self
        userConfigTableView.dataSource = self
        userConfigTableView.frame = CGRect(x: 0, y:myProfielViewHeight, width: viewWidth, height: userConfigTableViewHeight)
        userConfigTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        userConfigTableView.backgroundColor = UIColor.MyPageTableBGColor()
        //userConfigTableView.isScrollEnabled = false
        self.view.addSubview(userConfigTableView)
    }
    
    
    //
    func choseIconBtnClicked(sender: UIButton){
        
        // インスタンス生成
       let myImagePicker = UIImagePickerController()
        //myImagePicker.delegate = self
        myImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myImagePicker.navigationBar.barTintColor = UIColor.mainAppColor()
        myImagePicker.navigationBar.tintColor = UIColor.white
        myImagePicker.navigationBar.isTranslucent = false
        //myImagePicker.allowsEditing = false
        self.present(myImagePicker, animated: true, completion: nil)
    }
    
    
    
    // MARK: - TableViewのデリゲートメリット
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return changeUserInfoAry.count
    }
    
    //MARK: テーブルビューのセルの高さを計算する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if changeUserInfoAry[indexPath.row] == "" {
            return 24
        }else{
            return 44
        }
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell

        if indexPath.row == 0{
            cell.textLabel?.text = changeUserInfoAry[indexPath.row]
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell.textLabel?.textColor = UIColor.mainAppColor()
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }else if indexPath.row == 1{
            cell.backgroundColor = UIColor.MyPageTableBGColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }else if indexPath.row == 6{
            cell.backgroundColor = UIColor.MyPageTableBGColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }else{
            cell.textLabel?.text = changeUserInfoAry[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            //プロフィールのプレビューが押された
            let vc:ProfielViewController = ProfielViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            //ユーザー名の編集
            let vc:EditUserNameViewController = EditUserNameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        
        default:
            
            break
        }
        
        

        
    }

}
