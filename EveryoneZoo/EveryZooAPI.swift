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
    
    
    class func getRecentPosts() -> String{
        //新着取得を取得
        //let GET_RECENT_POSTS:String! = "/api/v0/posts/recent"
        return API_URL+API_VERSION+"posts/recent/"
    }
    
    class func getPopularPosts() -> String{
        //新着取得を取得
        //let GET_RECENT_POSTS:String! = "/api/v0/posts/recent"
        return API_URL+API_VERSION+"posts/popular/"
    }
    
    class func getZooNews()->String{
        //動物園のニュースの取得
        //http://minzoo.herokuapp.com/api/v0/zoo_news
        return API_URL+API_VERSION+"zoo_news"
    }
    
}
