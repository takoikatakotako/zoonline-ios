//
//  EveryZooConfig.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/04.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit


let APP_URL: String = "http://minzoo.herokuapp.com"

let CONTACT_PAGE_URL_STRING:String = "http://swiswiswift.sakura.ne.jp/zoonline/"
let TOS_PAGE_URL_STRING:String = "http://swiswiswift.sakura.ne.jp/zoonline/tos.html"


// MARK: - 広場画面


//新着取得
let GET_RECENT_POSTS:String! = "/api/v0/posts/recent"

//人気取得
let GET_POPULAR_POSTS:String! = "/api/v0/plaza/popular"

//詳細取得
let GET_POSTS_DATAILS:String! = "/api/v0/plaza/detail/" //+postID


//ユーザー情報
let GET_USER_INFO:String = "/api/v0/users/" //+userID

//ユーザーの投稿一覧
let POSTS:String = "/posts"
//http://minzoo.herokuapp.com/api/v0/users/1/posts

//ユーザーのフォロー一覧
let FOLLOWING:String = "/following"
//http://minzoo.herokuapp.com/api/v0/users/1/following

//ユーザーのお気に入りの取得
let FAVORITE_POSTS:String = "/favorite_posts"
//http://minzoo.herokuapp.com/api/v0/users/1/favorite_posts


//投稿のコメントを取得
let GETS_POSTS:String = "/api/v0/posts/"
//http://minzoo.herokuapp.com/api/v0/posts/2

//投稿のコメントを取得
let COMMENTS:String = "/comments"
//http://minzoo.herokuapp.com/api/v0/posts/2/comments

//フォローしているユーザーの最新の投稿を取得
let FOLLOWING_POSTS:String = "/following/posts"
//http://minzoo.herokuapp.com/api/v0/users/1/following/posts


//ログイン
let POST_LOGIN:String = "/api/v0/auth/sign_in"

//ニュース
let GET_NEWS:String = "/api/v0/zoo_news"

//http://minzoo.herokuapp.com/api/v0/zoo_news
