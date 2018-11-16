//
//  SetPostTagsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/02.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

protocol SetTagsDelegate: class {
    
    func setTags(ary:Array<String>)
}

class SetPostTagsViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!

    
    var postTagLabelHeight:CGFloat!
    var setTagTextFieldSpaceHeight:CGFloat!
    var setTagTextFieldHeight:CGFloat!
    var tagTableViewHeight:CGFloat!

    //segue
    var tagsAry:Array<String>!
    
    //ViewParts
    var setTagTextField:UITextField = UITextField()
    var tagTableView:UITableView = UITableView()
    
    //delegate
    weak var delegate: SetTagsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = self.view.frame.width
        viewHeight =  self.view.frame.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        postTagLabelHeight = viewWidth*0.14
        setTagTextFieldSpaceHeight = viewWidth*0.02
        setTagTextFieldHeight = viewWidth*0.15
        //tagTableViewHeight = viewHeight-(statusBarHeight+navigationBarHeight+postTagLabelHeight+setTagTextFieldSpaceHeight+setTagTextFieldHeight+tabBarHeight)
        tagTableViewHeight = viewHeight
        self.view.backgroundColor = UIColor.white

        setNavigationBar()
        setTextField()
        setTableView()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        delegate?.setTags(ary:tagsAry)
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.MainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        //「<戻る」を「<」のみにする
        navigationController!.navigationBar.topItem!.title = " "
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "タグの編集"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
        
        //閉じるボタン
        let rightNavBtn = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        self.navigationItem.rightBarButtonItem = rightNavBtn
    }
    
    
    func setTextField()  {
        
        //
        let grayView:UIView = UIView()
        grayView.backgroundColor = UIColor.LoginRegistSkyBlue()
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
        var linePos:CGFloat = postTagLabelHeight + setTagTextFieldSpaceHeight
        linePos = linePos + setTagTextFieldHeight!
        setTagTextFieldLine.frame = CGRect(x: viewWidth*0.1, y: linePos, width: viewWidth*0.8, height: 1)
        self.view.addSubview(setTagTextFieldLine)
        
    }
    

    func setTableView(){
        
        //デリゲートの設定
        tagTableView.delegate = self
        tagTableView.dataSource = self
        tagTableView.frame = CGRect(x: viewWidth*0.1, y: (postTagLabelHeight+setTagTextFieldSpaceHeight+setTagTextFieldHeight!)+2, width: viewWidth*0.8, height: tagTableViewHeight)
        tagTableView.register(TagListTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TagListTableViewCell.self))
        tagTableView.separatorInset = UIEdgeInsets.zero
        tagTableView.separatorInset = .zero
        tagTableView.separatorColor = UIColor.white
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(tagTableView)
    }
    
    
    
     //UITextFieldが編集された直前に呼ばれる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        
        if textField.text == "登録するタグ名"{
            textField.text = ""
        }
    }
    
     //UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
    }
    
     //改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        
        if  textField.text == ""{
            return true
        }
        
        tagsAry.append(textField.text!)
        tagTableView.reloadData()
        textField.text = "登録するタグ名"
        
        return true
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return tagsAry.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:TagListTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TagListTableViewCell.self), for: indexPath) as! TagListTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.tagLabel.text = tagsAry[tagsAry.count-indexPath.row-1]
        
        cell.deleateBtn.tag = tagsAry.count-indexPath.row-1
        cell.deleateBtn.addTarget(self, action:  #selector(deleatBtnClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
    
    //角丸ボタンが押されたら呼ばれます
    @objc func deleatBtnClicked(sender: UIButton){

        tagsAry.remove(at: sender.tag)
        tagTableView.reloadData()
    }
    
    //タグ画面を閉じる
    @objc internal func doClose(sender: UIButton){
        
        _ = self.navigationController?.popViewController(animated: true)
    }
}
