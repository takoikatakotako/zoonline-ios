//
//  ProfielViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/07.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class ProfielViewController: UIViewController {
    
    //width,height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var profielViewHeight:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        profielViewHeight = self.view.frame.width*0.63
        
        self.view.backgroundColor = UIColor.MyPageTableBGColor()
    
        setProfiel()
    }
    
    func setProfiel(){
        
        //自分の情報
        let profielView:UIView = UIView()
        profielView.frame = CGRect(x: 0, y: viewHeight*0.1, width: viewWidth, height: profielViewHeight)
        profielView.backgroundColor = UIColor.MyPageTableBGColor()
        self.view.addSubview(profielView)
        
        //卵アイコン
        let iconImgView:UIImageView = UIImageView()
        let iconImgViewHeight:CGFloat = profielView.frame.height*0.4
        iconImgView.frame =  CGRect(x: viewWidth/2-iconImgViewHeight/2, y: profielView.frame.height*0.1, width: iconImgViewHeight, height:iconImgViewHeight)
        iconImgView.layer.cornerRadius = iconImgViewHeight/2
        iconImgView.layer.masksToBounds = true
        iconImgView.image = UIImage(named:"sample_kabi1")
        profielView.addSubview(iconImgView)
        
        // 名前
        let nameLabel:UILabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y:  profielView.frame.height*0.5, width: viewWidth, height:profielView.frame.height*0.2)
        nameLabel.text = "道券カビゴン"
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 26)
        profielView.addSubview(nameLabel)
        
        // Introduce
        let introduceLabel:UILabel = UILabel()
        introduceLabel.frame = CGRect(x: viewWidth*0.05, y:  profielView.frame.height*0.7, width: viewWidth*0.9, height:profielView.frame.height*0.25)
        introduceLabel.text = "わたしは、サーバルキャットのサーバル！。かりごっこが大好きなんだー"
        introduceLabel.textAlignment = NSTextAlignment.center
        introduceLabel.font = UIFont.systemFont(ofSize: 14)
        introduceLabel.textColor = UIColor.black
        introduceLabel.numberOfLines = 0
        profielView.addSubview(introduceLabel)
    }
    
    
}
