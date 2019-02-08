import UIKit

//let API_URL:String = "http://minzoo.herokuapp.com/api/"
//let API_URL:String = "http://localhost:3000/api/"
let API_URL: String = "https://www.zooforeveryone.work/api/"

//let API_CONFIRM_SUCCESS_URL = "http://minzoo.herokuapp.com/register_confirmation"
let API_CONFIRM_SUCCESS_URL = "https://www.zooforeveryone.work/register_confirmation"

let API_VERSION: String = "v0/"

let CONTACT_PAGE_URL_STRING: String = "https://docs.google.com/forms/d/1jTJbYnHRE-IJVgkazqw9PYn0GIQYsT7Kj1ApivQW0AA/edit"
let TOS_PAGE_URL_STRING: String = "http://team-sommelier.com/tos.html"
let PRIVACY_PAGE_URL: String = "http://team-sommelier.com/privacy.html"

class EveryZooAPI: NSObject {

    class func getFavoritePosts(userID: Int) -> String {

        return API_URL+API_VERSION+"users/"+String(userID)+"/favorite_posts"
    }

    class func getFriends(userID: Int) -> String {
        //自分のフレンズ（フォロワーの取得
        return API_URL+API_VERSION+"users/" + String(userID) + "/following/"
    }

    class func getTimeLinePosts(userID: Int) -> String {
        //タイムラインの投稿を取得する
        return API_URL+API_VERSION+"users/" + String(userID) + "/following/posts/"
    }

    class func getRecentPosts() -> String {
        //新着取得を取得
        return API_URL+API_VERSION+"posts/recent/"
    }

    class func getPopularPosts() -> String {
        //新着取得を取得
        return API_URL+API_VERSION+"plaza/popular/"
    }

    class func getZooNews() -> String {
        //動物園のニュースの取得
        //http://minzoo.herokuapp.com/api/v0/zoo_news
        return API_URL+API_VERSION+"zoo_news"
    }

    class func getOfficialNews() -> String {
        //オフィシャルの投稿の取得
        //https://blog.team-sommelier.com/wp-json/wp/v2/posts/
        return "https://blog.team-sommelier.com/wp-json/wp/v2/posts/"
    }

    class func getDoFavoritePost(userID: Int, postID: Int) -> String {

      return API_URL+API_VERSION+"users/"+String(userID)+"/favorite_post/" + String(postID)
    }

    class func getPostsInfo(postID: Int) -> String {
        //投稿の詳細の取得、投稿の削除
        return API_URL+API_VERSION+"posts/"+String(postID)
    }

    class func getSignUp() -> String {

        //サインアップ、新規登録
        return API_URL+API_VERSION+"auth/"
    }

    class func getEditName() -> String {

        //ユーザー名の変更
        return API_URL+API_VERSION+"auth/"
    }

    class func getSignIn() -> String {

        //サインイン
        return API_URL+API_VERSION+"auth/sign_in/"
    }

    class func getComments(postID: Int) -> String {

        //投稿に紐づいたコメントを取得する
        return API_URL+API_VERSION+"posts/" + String(postID) + "/comments/"
    }

    class func deleateComments(commentID: Int) -> String {

        //投稿に紐づいたコメントを削除する
        return API_URL+API_VERSION + "comments/" + String(commentID)
    }

    class func getDoComments(postID: Int) -> String {

        //コメントをする
        ///api/v0/posts/:post_id/comments
        return API_URL+API_VERSION+"/posts/"+String(postID)+"/comments"
    }

    class func getUploadPicture() -> String {

        //画像をアップロードする
        return API_URL+API_VERSION+"picture/"
    }

    class func getUserPosts(userID: Int) -> String {
        //ユーザーの投稿を取得する
        return API_URL + API_VERSION + "users/"+String(userID)+"/posts"
    }

    class func getUserInfo(userID: Int) -> String {

        //ユーザーの情報を取得する
        return API_URL + API_VERSION + "users/"+String(userID)
    }

    class func getFollower(userID: Int) -> String {
        //フォロワーを取得する
        return API_URL+API_VERSION+"users/" + String(userID)+"/followed"
    }

}
