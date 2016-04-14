//
//  DetailViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/16.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import SwiftyJSON
import SwiftHTTP

class DetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var detailTable: UITableView!
    
    var product_info: NSDictionary = NSDictionary()
    var prodId = ""
    
    // 页面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expandedIndexpaths = []
        
        // 数据
        self.prodId = self.cache.cacheGetString("searchkey") as String
        self.product_info = self.sampleData.getDetailProductInfo(self.prodId)
        
        // 设置TableView的背景色
        self.detailTable.backgroundView?.backgroundColor = UIColor.clearColor()
        self.detailTable.backgroundColor = UIColor.clearColor()
        
        // 设置分割线颜色
        self.detailTable.separatorColor = self.colors.tableview_separator_color
        
        // 分割线
        self.detailTable.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // 设置行高
        self.detailTable.estimatedRowHeight = 30.0
        self.detailTable.rowHeight = UITableViewAutomaticDimension
        
        // 是否已收藏
        if self.coreDataDao.isExistMyProduct(self.prodId) {
            let rightBtn = UIBarButtonItem(title: "取消收藏", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.deleteMyProduct))
            self.navigationItem.rightBarButtonItem = rightBtn
        } else {
            let rightBtn = UIBarButtonItem(title: "收藏", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.addMyProduct))
            self.navigationItem.rightBarButtonItem = rightBtn
        }
        
//        // 显示广告
//        self.ad.showAd(self.view, bottomLayoutGuide: self.bottomLayoutGuide,topviews: [self.detailTable])
//        for button: UIButton in ADScrollView.adButtons {
//            button.addTarget(self, action: #selector(self.adButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteMyProduct() {
        self.coreDataDao.deleteMyProduct(self.prodId)
        let rightBtn = UIBarButtonItem(title: "收藏", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.addMyProduct))
        self.navigationItem.setRightBarButtonItem(rightBtn, animated: true)
    }
    
    func addMyProduct() {
        self.coreDataDao.addMyProduct(self.product_info)
        let rightBtn = UIBarButtonItem(title: "取消收藏", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.deleteMyProduct))
        self.navigationItem.setRightBarButtonItem(rightBtn, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.sampleData.detail_titles.count
    }
    
    var expandedIndexpaths:[NSIndexPath]!
    var diyrowheight: CGFloat = 0
    
    // 设定TableViewCell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell: DetailImageTableViewCell!
            
            // 为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "DetailImageCell"
            
            // 同一形式的单元格重复使用，在声明时已注册
            cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as! DetailImageTableViewCell
            
            if (cell == nil) {
                cell = DetailImageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            }
            
            // 右侧箭头按钮不显示
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            // 显示图片
            cell.prodImage?.image = UIImage(named: self.product_info.objectForKey("image") as! String)
            
            // 点击动作
            cell.jumpBtn.addTarget(self, action: #selector(DetailViewController.jumpClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            // 选中颜色
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            // 背景色设定
            cell.contentView.backgroundColor = UIColor.clearColor()
            cell.backgroundColor = UIColor.blackColor()
            
            // 最右边箭头图标
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            // 分割线
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            
            return cell
        } else if indexPath.row == 8 {
            
            var cell: DetailDiyDataTableViewCell!
            
            // 为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "DetailDiyDataCell"
            
            // 同一形式的单元格重复使用，在声明时已注册
            cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as! DetailDiyDataTableViewCell
            
            if (cell == nil) {
                cell = DetailDiyDataTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            }
            
            cell.containerView.layer.masksToBounds = true
            
            let values: [String] = self.sampleData.getDetailProductDiyInfo(self.prodId).objectForKey("diyData") as! [String]
            
            //屏幕宽度
            let screenWidth = UIScreen.mainScreen().bounds.size.width - 30
            
            // 间距
            let padding = CGSizeMake(8, 8)
            
            let lblsize = CGSizeMake(screenWidth - 30 - padding.width, 30)
            let btnsize = CGSizeMake(30, 30)
            
            // 第一个标签的起点
            var size = CGSizeMake(0, lblsize.height + padding.height)
            for value in values {
                let valuelbl = UILabel(frame: CGRect(x: size.width, y: size.height, width: lblsize.width, height: lblsize.height))
                valuelbl.text = value
                valuelbl.font = self.colors.tableviewcell_context_font
                valuelbl.textColor = self.colors.detail_tbcell_fontcolor
                let btn = UIButton(frame: CGRect(x: screenWidth - btnsize.width, y: size.height, width: btnsize.width, height: btnsize.height))
                btn.setImage(UIImage(named: "no-good"), forState: UIControlState.Normal)
                btn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                btn.tag = 0
                btn.addTarget(self, action: #selector(self.goodClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                                
                cell.containerView.addSubview(valuelbl)
                cell.containerView.addSubview(btn)

                size.height = size.height + padding.height + btnsize.height
            }
            self.diyrowheight = CGFloat(Float(values.count + 1)) * (btnsize.height + padding.height)
            
            if values.count == 0 {
                cell.isExpandable = false
                cell.constrainViewHeight = lblsize.height
            } else if values.count > 0 && values.count < 3  {
                cell.isExpandable = false
                cell.constrainViewHeight = self.diyrowheight
            } else {
                cell.isExpandable = true
                
                if  expandedIndexpaths.contains(indexPath) {
                    cell.constrainViewHeight = self.diyrowheight
                    cell.expanded  = true
                }else {
                    cell.constrainViewHeight = (btnsize.height + padding.height) * 3
                    cell.expanded  = false
                }
            }
            
            cell.expandClosure = {() -> Void in
                if !cell.expanded! {
                    self.expandedIndexpaths.append(indexPath)
                }else{
                    let index = self.expandedIndexpaths.indexOf(indexPath)
                    self.expandedIndexpaths.removeAtIndex(index!)
                }
                let offset: CGPoint = tableView.contentOffset
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                tableView.setContentOffset(offset, animated: true)
            }
            
            cell.addInfo = {() -> Void in
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("calc2") as UIViewController
                vc.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
            // 选中颜色
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            // 背景色设定
            cell.contentView.backgroundColor = UIColor.clearColor()
            cell.backgroundColor = UIColor.clearColor()
            cell.containerView.backgroundColor = UIColor.clearColor()
            
            // 最右边箭头图标
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            // 分割线
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            
            return cell
        } else {
            let cell: UITableViewCell!
            
            // 为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "DetailCell"
            
            // 同一形式的单元格重复使用，在声明时已注册
            cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.None
            if self.sampleData.detail_titles[indexPath.row][1] == "1" {
                cell.textLabel?.font = self.colors.tableviewcell_title_font
                cell.textLabel?.text = self.sampleData.detail_titles[indexPath.row][0]
            } else if self.sampleData.detail_titles[indexPath.row][1] == "2" {
                let title = self.sampleData.detail_titles[indexPath.row][0]
                let value = self.product_info.objectForKey(self.sampleData.detail_titles[indexPath.row][2]) as! String
                cell.textLabel?.font = self.colors.tableviewcell_context_font
                if title == "" {
                    cell.textLabel?.text = value
                } else {
                    cell.textLabel?.text = String(format: "%@：%@", arguments: [title, value])
                }
            }
            
            // 折行
            cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell.textLabel?.numberOfLines = 0
            
            // 选中颜色
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            // 字体颜色
            cell.textLabel?.textColor = self.colors.detail_tbcell_fontcolor
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
    }
    
    func goodClick(sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "good"), forState: UIControlState.Normal)
            sender.tag = 1
        } else {
            sender.tag = 0
            sender.setImage(UIImage(named: "no-good"), forState: UIControlState.Normal)
        }
    }
    
    // 显示图片事件
    func jumpClick(sender: UIButton) {
        //传递数据存入缓存
        self.cache.cacheSetString("imageName", value: self.product_info.objectForKey("image") as! NSString)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("image") as UIViewController
        // 弹出框的背景色半透明
        vc.view.backgroundColor = colors.translucent_black
        vc.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(vc, animated: true, completion: nil)
    }
}