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
        profielViewHeight = self.view.frame.width*0.56
        
        self.view.backgroundColor = UIColor.white
        
        //自分の情報
        let profielView:UIView = UIView()
        profielView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: profielViewHeight)
        profielView.backgroundColor = UIColor.gray
        self.view.addSubview(profielView)
        
        //卵アイコン
        let iconBaseBtn:UIButton = UIButton()
        let iconBaseBtnHeight:CGFloat = profielView.frame.height*0.44
        iconBaseBtn.frame =  CGRect(x: viewWidth/2-iconBaseBtnHeight/2, y: profielView.frame.height*0.1, width: iconBaseBtnHeight, height:iconBaseBtnHeight)
        iconBaseBtn.layer.cornerRadius = iconBaseBtnHeight/2
        iconBaseBtn.layer.masksToBounds = true
        iconBaseBtn.setBackgroundImage(UIImage(named:"sample_kabi1"), for: UIControlState.normal)
        profielView.addSubview(iconBaseBtn)
        
        // 名前
        let nameLabel:UILabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y:  profielView.frame.height*0.6, width: viewWidth, height:profielView.frame.height*0.2)
        nameLabel.text = "道券カビゴン"
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 28)
        profielView.addSubview(nameLabel)
        
        // Mail
        let introduceLabel:UILabel = UILabel()
        introduceLabel.frame = CGRect(x: viewWidth*0.05, y:  profielView.frame.height*0.75, width: viewWidth*0.9, height:profielView.frame.height*0.5)
        introduceLabel.text = "わたしは、サーバルキャットのサーバル！。かりごっこが大好きなんだー"
        introduceLabel.textAlignment = NSTextAlignment.center
        introduceLabel.font = UIFont.systemFont(ofSize: 12)
        introduceLabel.textColor = UIColor.red
        introduceLabel.numberOfLines = 0
        profielView.addSubview(introduceLabel)
        
        

    }
}
