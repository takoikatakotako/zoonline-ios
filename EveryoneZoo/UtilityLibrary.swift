//
//  UtilityLibrary.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/20.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class UtilityLibrary: NSObject {

    class func calcTextViewHeight(text:String,width:CGFloat,font:UIFont)->CGFloat{
        
        let calcTextView:UITextView = UITextView()
        calcTextView.frame = CGRect(x: 0, y: 0, width:width, height: 5)
        calcTextView.font = font
        calcTextView.text = text
        calcTextView.sizeToFit()
        
        return calcTextView.frame.size.height
    }
    

}


