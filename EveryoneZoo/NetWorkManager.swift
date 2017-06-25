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
    
    
    // MARK: - Login
    //非同期処理なので、VCに記述
    
    
    //post:http://minzoo.herokuapp.com/api/v0/example
    func postSample(){
        
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        
        Alamofire.request("http://minzoo.herokuapp.com/api/v0/example", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
}
