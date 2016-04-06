//
//  LoginViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/18.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var weixinBtn: UIButton!
    @IBOutlet weak var weiboBtn: UIButton!
    
    var colors: Colors = Colors()
    var coreDataDao: CoreDataDao = CoreDataDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.view.layer.contents = UIImage(named: "login-background")!.CGImage
        
        // 设置微信按钮阴影色
        self.weixinBtn.layer.shadowColor =  self.colors.login_weixin_shadow_color
        
        // 设置微博按钮
        self.weiboBtn.layer.shadowColor =  self.colors.login_weibo_shadow_color
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.checkAccessToken()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func weiboLogin() {
        let request: WBAuthorizeRequest = WBAuthorizeRequest()
        request.redirectURI = kRedirectURI
        request.scope = "all"
        request.userInfo = ["SSO_From": "LoginViewController"]
        WeiboSDK.sendRequest(request)
    }
    
    @IBAction func buttonAction() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("side1") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
