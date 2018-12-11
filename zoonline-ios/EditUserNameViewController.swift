//
//  EditUserNameViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/11.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class EditUserNameViewController: UIViewController, UITextFieldDelegate {

    //width, height
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var statusBarHeight: CGFloat!
    private var navigationBarHeight: CGFloat!

    let userNameTextFIeld: UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!

        self.view.backgroundColor = UIColor.white

        setNavigationBar()

        // 名前
        let nameLabel: UILabel = UILabel()
        nameLabel.frame = CGRect(x: viewWidth*0.05, y: viewHeight*0.1, width: viewWidth*0.9, height: 24)
        nameLabel.text = "ユーザー名を変更します"
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(nameLabel)

        //ユーザー名入力欄
        userNameTextFIeld.text = UtilityLibrary.getUserName()
        userNameTextFIeld.delegate = self
        userNameTextFIeld.textAlignment = NSTextAlignment.center
        userNameTextFIeld.frame = CGRect(x: viewWidth*0.05, y: viewHeight*0.18, width: viewWidth*0.9, height: 40)
        userNameTextFIeld.textColor = UIColor.gray
        self.view.addSubview(userNameTextFIeld)

        //userNameTextFIeldUnderLine
        let userNameTextFIeldLine: UIView = UIView()
        userNameTextFIeldLine.frame = CGRect(x: viewWidth*0.05, y: viewHeight*0.18+40+2, width: viewWidth*0.9, height: 1)
        userNameTextFIeldLine.backgroundColor = UIColor.gray
        self.view.addSubview(userNameTextFIeldLine)

        //ChangeButton
        let changeUserNameBtn: UIButton = UIButton()
        changeUserNameBtn.frame = CGRect(x: viewWidth*0.1, y: viewHeight*0.3, width: viewWidth*0.8, height: viewWidth*0.15)
        changeUserNameBtn.backgroundColor = UIColor.init(named: "main")
        changeUserNameBtn.setTitle("変更を保存", for: UIControl.State.normal)
        changeUserNameBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        changeUserNameBtn.layer.masksToBounds = true
        changeUserNameBtn.layer.cornerRadius = 4.0
        changeUserNameBtn.addTarget(self, action: #selector(changeUserNameBtn(sender:)), for: .touchUpInside)
        self.view.addSubview(changeUserNameBtn)

    }

    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {

        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: "main")
        self.navigationController?.navigationBar.isTranslucent = false

        //ナビゲーションアイテムを作成
        let titleLabel: UILabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ユーザー名の変更"
        titleLabel.textColor = UIColor.white

        self.navigationItem.titleView = titleLabel
    }

    //名前の変更ボタン押されたら呼ばれます
    @objc internal func changeUserNameBtn(sender: UIButton) {

        if (userNameTextFIeld.text?.isEmpty)! {
            SCLAlertView().showInfo("エラー", subTitle: "ユーザー名の入力が必要です。")
            return
        }

        let parameters: Parameters = [
            "name": userNameTextFIeld.text!
        ]

        Alamofire.request(EveryZooAPI.getEditName(), method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON {response in

            switch response.result {
            case .success:
                print("Validation Successful")
                let json: JSON = JSON(response.result.value ?? kill)
                print(json)

            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }

    // MARK: - TextFieldのDelegateメソッド
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        textField.text = ""

    }

    //UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")

    }

    //改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")

        return true
    }
}
