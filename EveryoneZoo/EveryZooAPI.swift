//
//  EveryZooAPI.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/10/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

let API_URL:String = "http://minzoo.herokuapp.com/api/"
//let API_URL:String = "http://localhost:3000/api/"
let API_VERSION:String = "v0/"

let APP_URL: String = "http://minzoo.herokuapp.com"

let CONTACT_PAGE_URL_STRING:String = "http://swiswiswift.sakura.ne.jp/zoonline/"
let TOS_PAGE_URL_STRING:String = "http://minzoo.team-sommelier.com/tos.html"
let PRIVACY_PAGE_URL:String = "http://minzoo.team-sommelier.com/privacy.html"

class EveryZooAPI: NSObject {
    
    
    
    class func getFavoritePosts(userID:Int) -> String {
    
        return API_URL+API_VERSION+"users/"+String(userID)+"/favorite_posts"
    }
    
    class func getFriends(userID:Int) -> String{
        //自分のフレンズ（フォロワーの取得
        return API_URL+API_VERSION+"users/" + String(userID) + "/following/"
    }
    
    class func getTimeLinePosts(userID:Int) -> String{
        //タイムラインの投稿を取得する
        return API_URL+API_VERSION+"users/" + String(userID) + "/following/posts/"
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

    class func getDoFavoritePost(userID:Int,postID:Int) -> String{
        
      return API_URL+API_VERSION+"users/"+String(userID)+"/favorite_post/" + String(postID)
    }
    
    class func getPostsInfo(postID:Int)->String {
        //投稿の詳細の取得、投稿の削除
        return API_URL+API_VERSION+"posts/"+String(postID)
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
    
    class func getUploadPicture() -> String {
    
        //画像をアップロードする
        return API_URL+API_VERSION+"picture/"
    }
    
    class func getUserPosts(userID:Int) ->String{
        //ユーザーの投稿を取得する
        return API_URL + API_VERSION + "users/"+String(userID)+"/posts"
    }
    
    class func getUserInfo(userID:Int)->String{
    
        //ユーザーの情報を取得する
        return API_URL + API_VERSION + "users/"+String(userID)
    }
    
    class func getFollower(userID:Int) ->String {
        //フォロワーを取得する
        return API_URL+API_VERSION+"users/" + String(userID)+"/followed"
    }
    
}
