//
//  BaseNoAdViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/3/17.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class BaseNoAdViewController: UIViewController {
    
    var cache: CacheUtils = CacheUtils()
    var sampleData: SampleData = SampleData()
    var coreDataDao: CoreDataDao = CoreDataDao()
    var colors: Colors = Colors()
    
    override func viewDidLoad() {
        //标题栏logo设置
        let titleBtn = UIButton()
        titleBtn.setImage(UIImage(named: "title-logo"), forState: UIControlState.Normal)
        titleBtn.frame = CGRectMake(0, 0, 40, 40)
        titleBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        titleBtn.addTarget(self, action: #selector(BaseNoAdViewController.titleButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = titleBtn
        
        //返回按钮
        let leftbackBtn = UIBarButtonItem()
        leftbackBtn.title = "返回"
        self.navigationItem.backBarButtonItem = leftbackBtn
        
        // 设置背景
        self.view.layer.contents = UIImage(named: "background")!.CGImage
        
        // 状态栏文字颜色
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // 点击标题
    func titleButtonClick(button:UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("calc") as UIViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
