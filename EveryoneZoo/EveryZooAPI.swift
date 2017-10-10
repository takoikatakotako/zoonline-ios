//
//  EveryZooAPI.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/10/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

let API_URL:String = "http://minzoo.herokuapp.com/api/"
let API_VERSION:String = "v0/"

class EveryZooAPI: NSObject {
    
    
    
    class func getFavoritePosts(userID:Int) -> String {
    
        return API_URL+API_VERSION+USERS+String(userID)+"/favorite_posts"
    }
    
    class func getFriends(userID:Int) -> String{
        //自分のフレンズ（フォロワーの取得
        return API_URL+API_VERSION+USERS + String(userID) + "/following/"
    }
    
    class func getTimeLinePosts(userID:Int) -> String{
        //タイムラインの投稿を取得する
        return API_URL+API_VERSION+USERS + String(userID) + "/following/posts/"
    }
    
    
    class func getRecentPosts() -> String{
        //新着取得を取得
        return API_URL+API_VERSION+"posts/recent/"
    }
    
    class func getPopularPosts() -> String{
        //新着取得を取得
        return API_URL+API_VERSION+"plaza/popular/"
    }
    
    class func getZooNews()->String{
        //動物園のニュースの取得
        //http://minzoo.herokuapp.com/api/v0/zoo_news
        return API_URL+API_VERSION+"zoo_news"
    }
    
    
    class func getSignIn() -> String {
        
        //サインイン
        return API_URL+API_VERSION+"auth/sign_in/"
    }
    
    class func getComments(postID:Int) -> String {
        
        //投稿に紐づいたコメントを取得する
        return API_URL+API_VERSION+"posts/" + String(postID) + "/comments/"
    }
    
    class func getDoComments() -> String{
    
        //コメントをする
        return API_URL+API_VERSION+"comments/"
    }
    
}
