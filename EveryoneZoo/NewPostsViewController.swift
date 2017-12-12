//
//  NewPostsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/13.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON
import SDWebImage

protocol NewPostsDelegate: class  {
    func goDetailView(postID:Int)
    func startIndicator()
    func stopIndicator()
}

class NewPostsViewController: CustumViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //delegate
    weak var delegate: NewPostsDelegate?
    
    //width, height
    var pageMenuHeight:CGFloat!
    private var collectionViewHeight:CGFloat!
    
    //APIから取得したデーター
    var imageURLs:Array<String> = Array()
    var postIds:Array<Int> = Array()
    var isNetWorkConnect:Bool = true
    
    var myCollectionView : UICollectionView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageName = PageName.Field.rawValue
        
        //画面横サイズを取得
        self.viewWidth = self.view.frame.width
        self.viewHeight = self.view.frame.height
        self.collectionViewHeight = viewHeight - (statusBarHeight + navigationBarHeight + pageMenuHeight + tabBarHeight)

        let collectionFrame = CGRect(x: 0, y: 0, width: viewWidth, height: collectionViewHeight)
        
        // CollectionViewのレイアウトを生成.
        let layout = FieldCollectionViewFlowLayout()
        
        // CollectionViewを生成.
        myCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        myCollectionView.backgroundColor = UIColor.white
        
        // Cellに使われるクラスを登録.
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        self.view.addSubview(myCollectionView)
        
        if #available(iOS 11.0, *) {
            myCollectionView.contentInsetAdjustmentBehavior = .never
        }
    }

    // MARK: - Viewにパーツの設置
    
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Num: \(indexPath.row)")
        print("Number: \(indexPath.section * 6 + indexPath.row)")
    }
    
    //セクションあたりのセルの色を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    //セクションの総数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.backgroundColor = makeColor()
        let mainLabel = UILabel(frame: cell.frame)
        mainLabel.text = "\(indexPath.section)-\(indexPath.item)"
        mainLabel.textAlignment = .center
        mainLabel.backgroundColor = makeColor()
        cell.backgroundView = mainLabel
        cell.clipsToBounds = true
        cell.addSubview(mainLabel)
        return cell
    }
    //ランダムに色を生成する
    func makeColor() -> UIColor {
        let r: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let g: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let b: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let color: UIColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        return color
    }
}
