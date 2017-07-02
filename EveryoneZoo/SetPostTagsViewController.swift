//
//  SetPostTagsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/02.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class SetPostTagsViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var postTagLabelHeight:CGFloat!
    var setTagTextFieldSpaceHeight:CGFloat!
    var setTagTextFieldHeight:CGFloat!
    var tagTableViewHeight:CGFloat!

    
    //ViewParts
    var setTagTextField:UITextField = UITextField()
    var tagTableView:UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = self.view.frame.width
        viewHeight =  self.view.frame.height
        postTagLabelHeight = viewWidth*0.14
        setTagTextFieldSpaceHeight = viewWidth*0.02
        setTagTextFieldHeight = viewWidth*0.15
        tagTableViewHeight = viewWidth-(postTagLabelHeight+setTagTextFieldSpaceHeight+setTagTextFieldHeight)
        
        self.view.backgroundColor = UIColor.white

        setNavigationBar()
        setTextField()
        setTableView()
    }

    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        //「<戻る」を「<」のみにする
        navigationController!.navigationBar.topItem!.title = " "
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "タグの編集"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
        
        //右上の検索ボタン
        //serchNavBtn.tintColor = UIColor.white
        //serchNavBtn.action = #selector(rightBarBtnClicked(sender:))
    }
    
    
    func setTextField()  {
        
        //
        let grayView:UIView = UIView()
        grayView.backgroundColor = UIColor.PostScrollBGColor()
        grayView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: postTagLabelHeight)
        self.view.addSubview(grayView)
        
        let label:UILabel  = UILabel()
        label.frame = CGRect(x: viewWidth*0.1, y: 0, width: viewWidth*0.8, height: postTagLabelHeight)
        label.text = "投稿のタグ"
        self.view.addSubview(label)
        
        setTagTextField.frame = CGRect(x: viewWidth*0.1, y: postTagLabelHeight+setTagTextFieldSpaceHeight, width: viewWidth*0.8, height: setTagTextFieldHeight)
        setTagTextField.text = "登録するタグ名"
        setTagTextField.textColor = UIColor.gray
        setTagTextField.textAlignment = NSTextAlignment.left
        //setTagTextField.backgroundColor = UIColor.red
        setTagTextField.delegate = self
        self.view.addSubview(setTagTextField)
        
        let setTagTextFieldLine:UIView = UIView()
        setTagTextFieldLine.backgroundColor = UIColor.gray
        setTagTextFieldLine.frame = CGRect(x: viewWidth*0.1, y: postTagLabelHeight+setTagTextFieldSpaceHeight+setTagTextFieldHeight!, width: viewWidth*0.8, height: 1)
        self.view.addSubview(setTagTextFieldLine)
        
    }
    

    
    func setTableView(){
        
        //デリゲートの設定
        tagTableView.delegate = self
        tagTableView.dataSource = self
        tagTableView.frame = CGRect(x: viewWidth*0.1, y: (postTagLabelHeight+setTagTextFieldSpaceHeight+setTagTextFieldHeight!)+2, width: viewWidth*0.8, height: tagTableViewHeight)
        tagTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tagTableView)
    }
    
    
    
    /*
     UITextFieldが編集された直前に呼ばれる
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
    }
    
    /*
     UITextFieldが編集された直後に呼ばれる
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
    }
    
    /*
     改行ボタンが押された際に呼ばれる
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return 10
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = "adadadadada"
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
}
