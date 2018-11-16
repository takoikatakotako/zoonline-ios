//
//  UIColorExtension.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func DarkPink() -> UIColor {
        //濃いピンク ログアウトアイコン
        return UIColor.colorWithHexString("ff007a")
    }
    
    class func ShareRed() -> UIColor {
        //赤 シェアアイコン(マイページ)
        return UIColor.colorWithHexString("ff1f1a")
    }
    
    class func FollowYellowGreen() -> UIColor {
        //黄緑 フォロワーアイコン
        return UIColor.colorWithHexString("6ee600")
    }

    class func FavoriteOrange() -> UIColor {
        //オレンジ お気に入りアイコン
        return UIColor.colorWithHexString("ff8500")
    }
    
    class func ContactBluePurple() -> UIColor {
        //青紫色 お問い合わせアイコン
        return UIColor.colorWithHexString("8500ff")
    }
    
    class func PostListGreen() -> UIColor {
        //緑 投稿一覧アイコン
        return UIColor.colorWithHexString("00cc6a")
    }
    
    class func PostDetailIconGry() -> UIColor {
        //灰色 詳細画面のアイコン
        return UIColor.colorWithHexString("8e8e93")
    }
    
    class func MypageArrowGray() -> UIColor {
        //灰色 マイページの矢印
        return UIColor.colorWithHexString("c5c5ca")
    }
    
    class func DefaultIconLeg() -> UIColor {
        //デフォルトアイコン 足
        return UIColor.colorWithHexString("89c2ff")
    }
    
    class func DefaultIconShadow() -> UIColor {
        //デフォルトアイコン 影
        return UIColor.colorWithHexString("9aa7b2")
    }
    
    class func DefaultIconCircle() -> UIColor {
        //デフォルトアイコン 丸
        return UIColor.colorWithHexString("c4e0ff")
    }
    
    class func ErrorPenguinDarkBlue() -> UIColor {
        //エラーペンギン 深い紺色
        return UIColor.colorWithHexString("1e2935")
    }
    
    class func ErrorPenguinBodySkyBlue() -> UIColor {
        //エラーペンギン 腹の水色
        return UIColor.colorWithHexString("a4c5ed")
    }
    
    class func AccountRegistErrorPink() -> UIColor {
        //ピンク アカウント登録エラーメッセージ アカウント登録ボタン
        return UIColor.colorWithHexString("f14f80")
    }
    
    class func LoginRegistSkyBlue() -> UIColor {
        //水色 登録ボタン、ログインボタン
        return UIColor.colorWithHexString("00b4ff")
    }
    
    class func TextColorGray() -> UIColor {
        // 灰色 文字色とか線とか
        return UIColor.colorWithHexString("999999")
    }
    
    class func LiginCushionLightGray() -> UIColor {
        // 薄い灰色 ログインクッションのアイコン・文字色 投稿画面のカメラ
        return UIColor.colorWithHexString("b5b5b5")
    }
    
    class func CommentIconSkyBlue() -> UIColor {
        // タグアイコンとかコメントアイコンの水色
        return UIColor.colorWithHexString("7fcef4")
    }
    
    class func CommentListUserNameBlue() -> UIColor {
        // 青 コメント一覧UIのユーザー名の色
        return UIColor.colorWithHexString("0080ff")
    }
    
    class func CommentListUserIconBlue() -> UIColor {
        // 青 コメント一覧UIのユーザーアイコン
        return UIColor.colorWithHexString("40a0ff")
    }
    
    class func PostDetailFavPink() -> UIColor {
        // ピンク 詳細画面とかのファボアイコン
        return UIColor.colorWithHexString("ff92ae")
    }
 
    //カラーコードをUIColorに変換
    class func colorWithHexString (_ hex:String) -> UIColor {
        
        let cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if ((cString as String).count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(with: NSRange(location: 0, length: 2))
        let gString = (cString as NSString).substring(with: NSRange(location: 2, length: 2))
        let bString = (cString as NSString).substring(with: NSRange(location: 4, length: 2))
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(
            red: CGFloat(Float(r) / 255.0),
            green: CGFloat(Float(g) / 255.0),
            blue: CGFloat(Float(b) / 255.0),
            alpha: CGFloat(Float(1.0))
        )
    }
}
