//
//  BaseViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/3/17.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var adView : ADScrollView!
    
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
        titleBtn.addTarget(self, action: Selector("titleButtonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = titleBtn
        
        //返回按钮
        let leftbackBtn = UIBarButtonItem()
        leftbackBtn.title = "返回"
        self.navigationItem.backBarButtonItem = leftbackBtn
        
        // 设置背景
        self.view.layer.contents = UIImage(named: "background")!.CGImage
        
        // 显示广告
        self.adView.showAdLabels()
        for button: UIButton in ADScrollView.adButtons {
            button.addTarget(self, action: Selector("adButtonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
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
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("calc2") as UIViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // 点击广告
    func adButtonClick(button: UIButton) {
        //获取url
        let url: NSString = self.sampleData.adData[button.tag].objectForKey("url") as! NSString
        
        if url == "" {
            return
        }
        
        //传递数据存入缓存
        self.cache.cacheSetString("adUrl", value: url)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("adweb") as UIViewController
        
        self.navigationController?.showViewController(vc, sender: nil)
    }
}
