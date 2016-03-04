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

    var colors: Colors = Colors()
    var cache: CacheUtils = CacheUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置TableView的背景色
        self.optionsTable.backgroundView?.backgroundColor = UIColor.clearColor()
        self.optionsTable.backgroundColor = UIColor.clearColor()
        
        // 注册TableViewCell
        self.optionsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return menu_options.count
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
