//
//  ZooNavigationBar.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/09.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class ZooNavigationBar: UINavigationBar {

    var titleLabe:UILabel!
    
    var myView:UIView!
    
    /*
    override func draw(_ rect: CGRect) {
        //self.barTintColor = UIColor.mainAppColor()
        let navBarWidth:CGFloat = self.frame.width
        let navBarHeight:CGFloat = self.frame.height
        
        titleLabe.frame = CGRect(x: navBarWidth*0.3, y: 0, width: navBarWidth*0.4, height: navBarHeight)
        titleLabe.textAlignment = NSTextAlignment.center
        self.topItem!.titleView = titleLabe
               // print(self.frame.width)
    }
    
    func setText(str:String)  {
        self.titleLabe.text = str
        
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        print(frame)
        print(frame.width)
        
        myView = UIView()
        myView.frame = CGRect(x:0, y: 0, width: 40, height: 40)
        myView.backgroundColor = UIColor.red
        self.addSubview(myView)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*
        let navBarWidth:CGFloat! = frame.width
        let navBarHeight:CGFloat! = frame.height
        titleLabe = UILabel()
        titleLabe.frame = CGRect(x:navBarWidth*0.3, y: 0, width: navBarWidth*0.4, height: navBarHeight)
        titleLabe.textAlignment = NSTextAlignment.center
        titleLabe.text = "aaaaa"
        titleLabe.textColor = UIColor.red
        
        self.topItem?.titleView = titleLabe
 */
        self.barTintColor = UIColor.mainAppColor()
        self.isTranslucent = false
    }
}
