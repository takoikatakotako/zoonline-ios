//
//  UtilityLibrary.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/20.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire

class UtilityLibrary: NSObject {
    
    class func isLogin()->Bool{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var isLogin:Bool = false
        
        if (appDelegate.userDefaultsManager?.userDefaults.object(forKey: "KEY_login") != nil) {
            isLogin = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_login"))!
        }else{
            print("Error")
        }
        
        return isLogin
    }
    
    class func getUserID()->String{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userID:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserID"))!
        return userID
    }
    
    class func getUserName()->String{
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userName:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserName"))!
        return userName
    }
    
    class func getUserEmail()->String{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userEmail:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserEmail"))!
        return userEmail
    }
    
    class func getUserProfile()->String{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userProfile:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserProfile"))!
        return userProfile
    }
    
    class func getUserIconUrl()->String{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userIconUrl:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserIconUrl"))!
        return userIconUrl
    }
    
    class func setUserName(userName:String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(userName, forKey: "KEY_MyUserName")
        return
    }
    
    class func setUserProfile(userProfile:String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(userProfile, forKey: "KEY_MyUserProfile")
        return
    }
    
    class func setUserIconUrl(userIconUrl:String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(userIconUrl, forKey: "KEY_MyUserIconUrl")
        return
    }
    
    class func getAPIAccessHeader()->HTTPHeaders{
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let myAccessToken:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyAccessToken"))!
        let myClientToken:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyClientToken"))!
        let myExpiry:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyExpiry"))!
        let myUniqID:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUniqID"))!
        
        let headers: HTTPHeaders = [
            "access-token": myAccessToken,
            "client": myClientToken,
            "expiry": myExpiry,
            "uid": myUniqID
        ]
        
        return headers
    }
    
    class func calcTextViewHeight(text:String,width:CGFloat,font:UIFont)->CGFloat{
        
        let calcTextView:UITextView = UITextView()
        calcTextView.frame = CGRect(x: 0, y: 0, width:width, height: 5)
        calcTextView.font = font
        calcTextView.text = text
        calcTextView.sizeToFit()
        
        return calcTextView.frame.size.height
    }
    
    class func calcLabelSize(text:String,font:UIFont)->CGSize{
        
        let calcLabel:UILabel = UILabel()
        calcLabel.text = text
        calcLabel.font = font
        let rect:CGSize = calcLabel.sizeThatFits(CGSize.zero)
        
        return rect
    }
}
