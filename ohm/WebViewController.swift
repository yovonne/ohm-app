//
//  WebViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/23.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webview:UIWebView!
    @IBOutlet weak var loadingView: LoadingView!
    var backBtn: UIBarButtonItem = UIBarButtonItem()
    var forwardBtn: UIBarButtonItem = UIBarButtonItem()
    var reloadBtn: UIBarButtonItem = UIBarButtonItem()
    
    var cache: CacheUtils = CacheUtils()
    
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //标题栏logo设置
        let logoimg = UIImageView(image: UIImage(named: "title-logo"))
        logoimg.contentMode = UIViewContentMode.ScaleAspectFit
        logoimg.frame = CGRectMake(0, 0, 40, 40)
        self.navigationItem.titleView = logoimg
        
//        //返回按钮
//        let leftbackBtn = UIBarButtonItem()
//        leftbackBtn.title = "返回"
//        self.navigationItem.backBarButtonItem = leftbackBtn
        
        //返回按钮
//        let left: UIButton = UIButton(frame: CGRectMake(0, 0, 40, 40))
//        left.setImage(UIImage(named: "back-icon"), forState: UIControlState.Normal)
//        left.addTarget(self, action: "backHandle", forControlEvents: UIControlEvents.TouchUpInside)
//        let leftbackBtn: UIBarButtonItem = UIBarButtonItem()
//        leftbackBtn.customView = left
//        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
//        spacer.width = -10
//        self.navigationItem.leftBarButtonItems = [spacer, leftbackBtn]
        
        // 设置背景
        self.view.layer.contents = UIImage(named: "login-background")!.CGImage
        
        // 获取地址
        self.url = cache.cacheGetString("adUrl") as String
        
        // 加载网页
        let urlobj = NSURL(string:self.url)
        let request = NSURLRequest(URL: urlobj!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 20)
        self.webview.loadRequest(request);
        
        // 增加右侧按钮
        self.backBtn=UIBarButtonItem(image: UIImage(named: "back-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "backClicked:")
        self.forwardBtn=UIBarButtonItem(image: UIImage(named: "forward-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "forwardClicked:")
        self.reloadBtn=UIBarButtonItem(image: UIImage(named: "reload-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "reloadClicked:")
        self.navigationItem.rightBarButtonItems = [self.reloadBtn,self.forwardBtn,self.backBtn]
        
        // loading image view
        self.loadingView.create()
        self.view.bringSubviewToFront(self.loadingView)
        
    }
    
    //返回按钮
//    func backHandle() {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    func changeBarButtonStatus() {
        self.backBtn.enabled = self.webview.canGoBack
        self.forwardBtn.enabled = self.webview.canGoForward
    }
    
    func reloadClicked(sender:UIBarButtonItem) {
        self.webview.stopLoading()
        self.webview.reload()
    }
    
    func backClicked(sender:UIBarButtonItem) {
        self.webview.goBack()
    }
    
    func forwardClicked(sender:UIBarButtonItem) {
        self.webview.goForward()
    }
    
    func stopClicked(sender:UIBarButtonItem) {
        self.loadingView.stopLoading()
        self.webview.stopLoading()
        self.reloadBtn.image = UIImage(named: "reload-icon")
        self.reloadBtn.action = "reloadClicked:"
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        if error!.code != -999 {
            print(String(format: "didFailLoadWithError, code(%d)", error!.code))
            self.loadingView.stopLoading()
            self.webview.stopLoading()
            self.reloadBtn.image = UIImage(named: "reload-icon")
            self.reloadBtn.action = "reloadClicked:"
            let alertController = UIAlertController(title: "网页错误！",
                message: error!.localizedDescription,
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel,
                handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.loadingView.stopLoading()
        self.changeBarButtonStatus()
        self.reloadBtn.image = UIImage(named: "reload-icon")
        self.reloadBtn.action = "reloadClicked:"
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.loadingView.startLoading()
        self.changeBarButtonStatus()
        self.reloadBtn.image = UIImage(named: "stop-icon")
        self.reloadBtn.action = "stopClicked:"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}
