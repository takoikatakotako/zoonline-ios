//
//  PostViewBubleViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostViewBubleViewController: UIViewController {

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    
    var flug = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = self.view.frame.width
        viewHeight =  self.view.frame.height

        
        /*
        //viewの取得
        let sampleBG:UIImageView = UIImageView()
        sampleBG.frame = CGRect(x: 0, y: 100, width: viewWidth, height: viewWidth)
        sampleBG.image = UIImage(named:"sample_post")
        self.view.addSubview(sampleBG)
        
        //Button
        let postBtn:UIButton = UIButton()
        postBtn.frame = CGRect(x: 120, y: 200, width: 100, height: 100)
        postBtn.addTarget(self, action: #selector(basicButtonClicked(sender:)), for:.touchUpInside)
        postBtn.setBackgroundImage(UIImage(named:"sample_post_btn"), for: UIControlState.normal)
        self.view.addSubview(postBtn)
         */
    }

    func showPostView(){
        print("basicButtonBtnClicked")
        let nextView:PostViewController = PostViewController()
        self.present(nextView, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if flug == true{
            flug = false
            showPostView()
        }else{
            flug = true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
