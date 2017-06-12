//
//  NetWorkManager.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/04.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetWorkManager: NSObject {
    
    static let sharedInstance = NetWorkManager()

    //push:/api/v0/users/{:自分のuser_id}/following/{:フォローしたいuser_id}
    func followUser(myUserId:Int,followUserId:Int){
        
        let url:String = APP_URL_STRING + "/api/v0/users/" + String(myUserId) + "/following/" + String(followUserId)
        
        Alamofire.request(url, method: .post).responseJSON{ response in
            
            switch response.result {
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //delete:/api/v0/user/{:自分のuser_id}/following/{:フォローしたいuser_id}
    func unfollowUser(myUserId:Int,followUserId:Int){
        
        let url:String = APP_URL_STRING + "/api/v0/users/" + String(myUserId) + "/following/" + String(followUserId)
        
        Alamofire.request(url, method: .delete).responseJSON{ response in
            
            switch response.result {
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
