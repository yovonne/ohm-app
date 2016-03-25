//
//  MyProductViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/20.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit
import CoreData

class MyProductViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myProductTable: UITableView!
    
    // 搜索结果
    var products: [NSDictionary] = [NSDictionary]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 查询数据
        self.products = self.coreDataDao.searchMyProducts()
        self.myProductTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 回到主页
        let homeBtn=UIBarButtonItem(image: UIImage(named: "home-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "goHome")
        self.navigationItem.rightBarButtonItem = homeBtn
        
        // 设置TableView的背景色
        self.myProductTable.backgroundView?.backgroundColor = UIColor.clearColor()
        self.myProductTable.backgroundColor = UIColor.clearColor()
        
        // 设置分割线颜色
        self.myProductTable.separatorColor = self.colors.tableview_separator_color
        
        // 分割线
        self.myProductTable.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // 显示广告
        self.adView.showAdLabels()
        for button: UIButton in ADScrollView.adButtons {
            button.addTarget(self, action: Selector("adButtonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        // 查询数据
        self.products = self.coreDataDao.searchMyProducts()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 返回首页
    func goHome() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("side1") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //传递数据存入缓存
        self.cache.cacheSetString("searchkey", value: self.products[indexPath.row].objectForKey("prodId") as! NSString)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("detail") as UIViewController
        
        self.navigationController?.showViewController(vc, sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.products.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: MyProductTableViewCell!
        
        // 为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "ProductCell"
        
        // 同一形式的单元格重复使用，在声明时已注册
        cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as! MyProductTableViewCell
        
        if (cell == nil) {
            cell = MyProductTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
        }
        
        // 右侧箭头按钮不显示
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        // 显示产品名称
        let prodId = self.products[indexPath.row].objectForKey("prodId") as! String
        let prodInfo: NSDictionary = self.sampleData.getDetailProductInfo(prodId)
        cell.prodNameLbl?.text = String(format: "雾化器名称：%@", prodInfo.objectForKey("prodName") as! String)
        // 字体大小
        cell.prodNameLbl?.font = self.colors.tableviewcell_context_font
        // 字体颜色
        cell.prodNameLbl?.textColor = self.colors.my_products_tbcell_fontcolor
        
        // 显示英文名称
        cell.prodENameLbl?.text = String(format: "英文名称：%@", prodInfo.objectForKey("prodEName") as! String)
        // 字体大小
        cell.prodENameLbl?.font = self.colors.tableviewcell_context_font
        // 字体颜色
        cell.prodENameLbl?.textColor = self.colors.my_products_tbcell_fontcolor
        
        // 显示类型
        cell.prodTypeLbl?.text = String(format: "类型：%@", prodInfo.objectForKey("prodType") as! String)
        // 字体大小
        cell.prodTypeLbl?.font = self.colors.tableviewcell_context_font
        // 字体颜色
        cell.prodTypeLbl?.textColor = self.colors.my_products_tbcell_fontcolor

        // 显示图片
        cell.prodImage?.image = UIImage(named: prodInfo.objectForKey("image") as! String)
        
        // 选中颜色
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        // 背景色设定
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        // 最右边箭头图标
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        // 我要认证
        let authentication = self.products[indexPath.row].objectForKey("authentication") as! Bool
        if authentication {
            cell.authenticationBtn.setImage(UIImage(named: "authentication-icon"), forState: UIControlState.Normal)
        } else {
            cell.authenticationBtn.setImage(UIImage(named: "no-authentication-icon"), forState: UIControlState.Normal)
            cell.authenticationBtn.addTarget(self, action: "authenticationClick:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        cell.authenticationBtn.tag = indexPath.row
        
        // 分割线
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    // 我要认证点击事件
    func authenticationClick(sender: UIButton) {
        sender.setImage(UIImage(named: "authentication-icon"), forState: UIControlState.Normal)
        let prodId = self.products[sender.tag].objectForKey("prodId") as! String
        self.coreDataDao.updateMyProductsAuthentication(prodId, authentication: true)
    }
    // 去掉多余行
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v: UIView = UIView.init(frame: CGRectZero)
        v.backgroundColor = UIColor.clearColor()
        return v
    }
    
}
