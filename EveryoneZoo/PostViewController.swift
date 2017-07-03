//
//  PostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SetTextDelegate{

    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var tableViewHeight:CGFloat!

    //views
    private var postTableView: UITableView!
    var myImagePicker: UIImagePickerController!


    //datas
    public var postImage:UIImage! = UIImage(named:"photoimage")
    public var postImageWidth:CGFloat! = 100
    public var postImageHeight:CGFloat! = 62
    public var titleStr: String! = "タイトルをつけてみよう"
    public var commentStr: String! = "コメントを書いてみよう"

    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (PARTS_HEIGHT_STATUS_BAR + PARTS_HEIGHT_NAVIGATION_BAR + PARTS_TABBAR_HEIGHT!)
        
        setNavigationBar()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       postTableView.reloadData()
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let statusBgView:UIView = UIView()
        statusBgView.frame = CGRect(x: 0, y: -PARTS_HEIGHT_NAVIGATION_BAR*2, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR*2)
        statusBgView.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBgView)
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "投稿する"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(postBarBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = leftNavBtn
    }
    
    
    //TableViewの設置
    func setTableView(){
        
        postTableView = UITableView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight))
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.separatorStyle = .none
        postTableView.backgroundColor = UIColor.MyPageTableBGColor()
        postTableView.separatorStyle = .none

        postTableView.register(PostImageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostImageTableViewCell.self))
        postTableView.register(PostSpaceTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostSpaceTableViewCell.self))
        postTableView.register(PostTextsTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostTextsTableViewCell.self))
        postTableView.register(PostTagTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostTagTableViewCell.self))
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(postTableView)
    }
    
    //MARK: ButtonActions
    
    //左側のボタンが押されたら呼ばれる
    internal func postBarBtnClicked(sender: UIButton){
        
        
        print("leftBarBtnClicked")
        
        let imageData = UIImagePNGRepresentation(postImage)!
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "picture", fileName: "swift_file.png", mimeType: "image/png")
            multipartFormData.append("1".data(using: String.Encoding.utf8)!, withName: "user_id")
        }, to:"http://minzoo.herokuapp.com/api/v0/picture")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(response.request ?? "response.request")  // original URL request
                    print(response.response ?? "response.response") // URL response
                    print(response.data ?? "response.data")     // server data
                    print(response.result)   // result of response serialization
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
            }
        }
        
    }
    
    
    //MARK: テーブルビューのセルの高さを計算する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            //投稿画像のView
            return viewWidth*(postImageHeight/postImageWidth)
        }else if indexPath.row == 2{
            //タイトルのセル
            return viewWidth*0.15
        }else if indexPath.row == 4{
            //コメントのセル
            //コメントの高さを計算して、規定の値と比較。高い方を返す
            var testHeight:CGFloat = UtilityLibrary.calcTextViewHeight(text: commentStr, width: viewWidth*0.8, font: UIFont.systemFont(ofSize: 14))
            testHeight += viewWidth*0.03
            if testHeight >  viewWidth*0.3{
                return testHeight
            }
            return viewWidth*0.3
        }else if indexPath.row == 6{
            //コメントのセル
            return viewWidth*0.3
        }else{
            //スペース部分
            return viewWidth*0.04
        }
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return 8
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            //画像選択View
            let cell:PostImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostImageTableViewCell.self), for: indexPath) as! PostImageTableViewCell
            cell.postImageView.image = postImage
            return cell
        }else if indexPath.row == 2 {
            //画像選択View
            let cell:PostTextsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTextsTableViewCell.self), for: indexPath) as! PostTextsTableViewCell
            cell.iconImageView.image = UIImage(named:"title_logo")
            cell.postTextView.text = titleStr
            return cell
        }else if indexPath.row == 4 {
            //画像選択View
            let cell:PostTextsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTextsTableViewCell.self), for: indexPath) as! PostTextsTableViewCell
            cell.iconImageView.image = UIImage(named:"comment_blue")
            cell.postTextView.text = commentStr
            return cell
        }else if indexPath.row == 6 {
            //タグの選択View
            let cell:PostTagTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTagTableViewCell.self), for: indexPath) as! PostTagTableViewCell
            return cell
        }else{
        
            //スペーサーView
            let cell:PostSpaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostSpaceTableViewCell.self), for: indexPath) as! PostSpaceTableViewCell
            return cell
        }
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        
        //画面遷移、投稿詳細画面へ
        if indexPath.row == 0{
            
            // インスタンス生成
            myImagePicker = UIImagePickerController()
            myImagePicker.delegate = self
            myImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            myImagePicker.navigationBar.barTintColor = UIColor.mainAppColor()
            myImagePicker.navigationBar.tintColor = UIColor.white
            myImagePicker.navigationBar.isTranslucent = false
            //myImagePicker.allowsEditing = false
            self.present(myImagePicker, animated: true, completion: nil)
            
        }else if indexPath.row == 2 {
            let writePosTextsVC:WritePostTextsViewController = WritePostTextsViewController()
            writePosTextsVC.text = titleStr
            writePosTextsVC.isTitle = true
            writePosTextsVC.navTitle = "タイトル"
            writePosTextsVC.delegate = self
            self.navigationController?.pushViewController(writePosTextsVC, animated: true)
        }else if indexPath.row == 4 {
            let writePosTextsVC:WritePostTextsViewController = WritePostTextsViewController()
            writePosTextsVC.text = commentStr
            writePosTextsVC.isTitle = false
            writePosTextsVC.navTitle = "コメント"
            writePosTextsVC.delegate = self
            self.navigationController?.pushViewController(writePosTextsVC, animated: true)
        }else if indexPath.row == 6{
            let SetPostTagsVC:SetPostTagsViewController = SetPostTagsViewController()
            SetPostTagsVC.tagsAry = []
            self.navigationController?.pushViewController(SetPostTagsVC, animated: true)
        }
        
    }
    
    func setTitle(str:String){
        titleStr = str
    }
    
    func setComment(str:String) {
        commentStr = str
    }
    
    
    //画像が選択された時に呼ばれる.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            postImage = image
            postImageWidth = postImage.size.width
            postImageHeight = postImage.size.height
            postTableView.reloadData()

        } else{
            print("Error:Class name : \(NSStringFromClass(type(of: self))) ")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //画像選択がキャンセルされた時に呼ばれる.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
}


