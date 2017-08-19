//
//  UserDefaultsManager.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/12.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class UserDefaultsManager: NSObject {
    
    static let sharedInstance = UserDefaultsManager()
    var userDefaults:UserDefaults = UserDefaults.standard
    
    override init() {
        userDefaults.register(defaults: ["KEY_login": false])
        userDefaults.register(defaults: ["KEY_MyUserID": ""])
        userDefaults.register(defaults: ["KEY_MyUserName": ""])
    }
    
    func setInitValues(){
    
    }
    
    func isLogin()->Bool{
        
        var isLogin:Bool = false
        
        if (userDefaults.object(forKey: "KEY_login") != nil) {
            isLogin = userDefaults.bool(forKey: "KEY_login")
        }else{
            print("Error")
        }
        
        return isLogin
    }
    
    
    func doLogin() {
        userDefaults.set(true, forKey: "KEY_login")
        
    }
    
    func doLogout(){
    
    }
}
