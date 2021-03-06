//
//  OptionsViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/18.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var optionsTable : UITableView!
    @IBOutlet weak var lvView: UIStackView!
    @IBOutlet weak var userIcon: UIButton!
    @IBOutlet weak var userIconBack: UIButton!
    @IBOutlet weak var userName: UILabel!

    var colors: Colors = Colors()
    var cache: CacheUtils = CacheUtils()
    var sampleData: SampleData = SampleData()
    var coreDataDao: CoreDataDao = CoreDataDao()
    
    var lv: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置TableView的背景色
        self.optionsTable.backgroundView?.backgroundColor = UIColor.clearColor()
        self.optionsTable.backgroundColor = UIColor.clearColor()
        
        // 设置分割线颜色
        self.optionsTable.separatorColor = self.colors.tableview_separator_color
        
        // 分割线
        self.optionsTable.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // 注册TableViewCell
        self.optionsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        
        // 用户等级
        self.lv = calcLv(self.sampleData.userexp)
        let lvimages: [UIImage] = calcLvImage(lv)
        for images in lvimages {
            let btn: UIButton = UIButton()
            btn.setImage(images, forState: UIControlState.Normal)
            btn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            self.lvView.addArrangedSubview(btn)
        }
        self.userIconBack.backgroundColor = self.colors.lv_colors[lv - 1]
        self.userIconBack.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.userIconBack.layer.shadowColor = self.colors.lv_colors[lv - 1].CGColor
        self.userIconBack.layer.shadowOpacity = 0.8
        
        let userInfo: NSDictionary? = self.coreDataDao.searchUserInfo()
        if userInfo != nil {
            self.userName.text = userInfo!.objectForKey("screen_name") as? String
            let iconurl = userInfo!.objectForKey("profile_image_url") as? String
            let iconImg = UIImage(data: NSData(contentsOfURL: NSURL(string: iconurl!)!)!)
            UIGraphicsBeginImageContext(CGSize(width: 60, height: 60))
            iconImg?.drawInRect(CGRect(x: 0, y: 0, width: 60, height: 60))
            let resizeIconImg = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.userIcon.setImage(resizeIconImg, forState: UIControlState.Normal)
            self.userIcon.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            self.userIcon.imageView?.layer.cornerRadius = 30
        }
    }
    
    // 注销
    @IBAction func logout() {
        self.coreDataDao.deleteUserInfo()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("login") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        self.sideMenuController()?.performSegueWithIdentifier(CenterSegue, sender: nil)
    }
    
    // 获取等级球图片
    func calcLvImage(lv: Int) -> [UIImage] {
        var images: [UIImage] = []
        for index in 1 ... lv {
            images.append(UIImage(named: String(format: "lv%d", index))!)
        }
        var index = lv + 1
        while index <= 6 {
            images.append(UIImage(named: "lv0")!)
            index += 1
        }
        return images
    }
    
    // 等级计算
    func calcLv(exp: Int) -> Int {
        var index = lvexps.count - 1
        while exp < lvexps[index] {
            index -= 1
        }
        return index + 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return menu_options.count
    }
    
    // 去掉多余行
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v: UIView = UIView.init(frame: CGRectZero)
        v.backgroundColor = UIColor.clearColor()
        return v
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        // 为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "OptionCell"
        
        // 同一形式的单元格重复使用，在声明时已注册
        cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.textLabel?.text = menu_options[indexPath.row].objectForKey("title") as? String
        
        // 选中颜色
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        // 字体大小
        cell.textLabel?.font = self.colors.tableviewcell_leftmenu_font
        // 字体颜色
        cell.textLabel?.textColor = self.colors.options_tbcell_fontcolor
        
        // 背景色设定
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        // 最右边箭头图标
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        // 分割线
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboardId = menu_options[indexPath.row].objectForKey("storyboardId") as! String
        if (storyboardId != "") {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyboardId) as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
            self.sideMenuController()?.performSegueWithIdentifier(CenterSegue, sender: nil)
        } else {
            self.sideMenuController()?.performSegueWithIdentifier(CenterSegue, sender: nil)
        }
    }
    

}
