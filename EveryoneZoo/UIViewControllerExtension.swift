//
//  UIViewControllerExtension.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/11/16.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class CustumViewController:UIViewController {

    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    
    private var indicator:UIActivityIndicatorView!
    
    func showIndicater() {
        let rv = UIApplication.shared.keyWindow! as UIWindow
        let width:CGFloat = rv.frame.size.width
        let height:CGFloat = rv.frame.size.height
        let indicatorSize:CGFloat = rv.frame.size.width * 0.4
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: (width-indicatorSize)/2, y: (height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.color = UIColor.MainAppColor()
        indicator.hidesWhenStopped = true
        rv.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func hideIndicator() {
        indicator.removeFromSuperview()
    }
}
