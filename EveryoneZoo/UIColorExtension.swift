//
//  UIColorExtension.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

extension UIColor {
    /*class func rgb(#r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }*/
    
    class func segmetRightBlue() -> UIColor {
        return UIColor.init(red: (18.0/256), green: (138.0/256), blue: (220/256), alpha: 1.0)
    }
    
    class func mainAppColor() -> UIColor {
        return UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
    }
    
    class func tabIconSelected() -> UIColor {
        return UIColor(red: (11.0/256), green: (97.0/256), blue: (254.0/256), alpha: 1.0)
    }
    
    class func tabNonIconSelected() -> UIColor {
        return UIColor(red: (89.0/256), green: (89.0/256), blue: (89.0/256), alpha: 1.0)
    }
}
