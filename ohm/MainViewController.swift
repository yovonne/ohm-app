//
//  MainViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/15.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import SwiftHTTP
import SwiftyJSON

class MainViewController: BaseViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var searchTable : UITableView!
    @IBOutlet weak var initView : UIScrollView!
    @IBOutlet weak var historyTable : UITableView!
    @IBOutlet weak var recommentView : UIView!
    @IBOutlet weak var loadingView: LoadingView!
    
    // 历史记录
    var ctrlsel:[NSDictionary] = []
    
    // 搜索结果
    var searchsel: [NSDictionary] = []
    
    // 页面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置TableView的背景色
        self.searchTable.backgroundView?.backgroundColor = UIColor.clearColor()
        self.searchTable.backgroundColor = UIColor.clearColor()
        self.historyTable.backgroundView?.backgroundColor = UIColor.clearColor()
        self.historyTable.backgroundColor = UIColor.clearColor()
        
        // 设置分割线颜色
        self.searchTable.separatorColor = self.colors.tableview_separator_color
        self.historyTable.separatorColor = self.colors.tableview_separator_color
        
        // 启动时隐藏查询结果
        self.searchTable.hidden = true
        self.initView.hidden = false
        
        // 注册TableViewCell
        self.searchTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        self.historyTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        
        // 分割线
        self.searchTable.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        self.historyTable.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // loading image view
        self.loadingView.create()
        self.view.bringSubviewToFront(self.loadingView)
        
        // 显示搜索历史
        self.showHistory()
        
        // 显示大家都在搜
        self.showRecomment()
        
        // 显示广告
        self.ad.showAd(self.view, bottomLayoutGuide: self.bottomLayoutGuide,topviews: [self.initView, self.searchTable])
        for button: UIButton in ADScrollView.adButtons {
            button.addTarget(self, action: #selector(self.adButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }

    }

    // 通过title计算label长度
    func getSizeByString(string: NSString, font: CGFloat) ->CGSize {
        let options: NSStringDrawingOptions = OCUtils.stringDrawingOptions()
        var size = string.boundingRectWithSize(CGSizeMake(999,25), options:options, attributes: [NSFontAttributeName :UIFont.systemFontOfSize(font)], context: nil).size
        size.width += 20

        return size
    }
    
    // 显示搜索历史
    func showHistory() {
        self.ctrlsel = self.coreDataDao.searchHistory(false)
        self.historyTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchTable.hidden = false
        self.initView.hidden = true
        searchBar.showsCancelButton = true
        
        var cancelButton: UIButton?
        let topView: UIView = searchBar.subviews[0]
        for view in topView.subviews  {
            if view.isKindOfClass(NSClassFromString("UINavigationButton")!){
                cancelButton =  view as? UIButton
                break
            }
        }
        if (cancelButton != nil) {
            cancelButton?.setTitle("取消", forState: UIControlState.Normal)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        // 显示初始页面
        self.searchTable.hidden = true
        self.initView.hidden = false
        searchBar.showsCancelButton = false
    }
    
    // 搜索触发事件
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchsel = []
        if searchBar.text != "" {
            // 显示查询结果
            self.searchTable.hidden = false
            self.initView.hidden = true
            for info in sampleData.data {
                let prodName: NSString = info.objectForKey("prodName") as! NSString
                let prodEName: NSString = info.objectForKey("prodEName") as! NSString
                if prodName.lowercaseString.hasPrefix(searchBar.text!.lowercaseString) {
                    self.searchsel.append(["prodId":info.objectForKey("prodId") as! NSString,"prodName":prodName])
                } else {
                    if prodEName.lowercaseString.hasPrefix(searchBar.text!.lowercaseString) {
                        self.searchsel.append(["prodId":info.objectForKey("prodId") as! NSString,"prodName":prodName])
                    }
                }
            }
            self.searchTable.reloadData()
        } else {
            // 显示初始页面
            self.searchTable.hidden = true
            self.initView.hidden = false
            searchBar.showsCancelButton = false
        }
        searchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        if tableView.isEqual(self.searchTable) {
            return self.searchsel.count
        }else{
            return self.ctrlsel.count
        }
    }
    
    // 点击TableViewCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if tableView.isEqual(self.searchTable) {
            // 搜索结果
            self.coreDataDao.addHistory(cell.textLabel!.text!, prodId: self.searchsel[indexPath.row].objectForKey("prodId") as! String)
            showHistory()
            
            //传递数据存入缓存
            self.cache.cacheSetString("searchkey", value: self.searchsel[indexPath.row].objectForKey("prodId") as! NSString)

        } else {
            //传递数据存入缓存
            self.cache.cacheSetString("searchkey", value: self.ctrlsel[indexPath.row].objectForKey("prodId") as! NSString)
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("detail") as UIViewController
        
        self.navigationController?.showViewController(vc, sender: nil)
    }
    
    // 设定TableViewCell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        if tableView.isEqual(self.searchTable) {
            // 搜索结果
            // 为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SearchCell"
            
            // 同一形式的单元格重复使用，在声明时已注册
            cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = self.searchsel[indexPath.row].objectForKey("prodName") as? String
            
        } else {
            // 历史记录
            // 为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "HistoryCell"
            
            // 同一形式的单元格重复使用，在声明时已注册
            cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = self.ctrlsel[indexPath.row].objectForKey("prodName") as? String
        }
        // 右侧箭头按钮不显示
        cell.accessoryType = UITableViewCellAccessoryType.None
        // 选中颜色
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        // 字体大小
        cell.textLabel?.font = self.colors.tableviewcell_context_font
        // 字体颜色
        cell.textLabel?.textColor = self.colors.main_tbcell_fontcolor
        // 左边图标
        cell.imageView?.image = UIImage(named: "history-icon")
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
    
    // 清空搜索历史
    @IBAction func clearHistory() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        do {
            let request = NSFetchRequest(entityName: "SearchHistoryEntity")

            let historyEntitys = try context.executeFetchRequest(request)
            
            for one in historyEntitys {
                context.deleteObject(one as! NSManagedObject)
            }
            
            try context.save()
            
            self.ctrlsel = []
            self.historyTable.reloadData()
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
    }
    
    // 点击推荐
    func labelsClick(button: UIButton) {
        self.coreDataDao.addHistory(button.titleLabel!.text!, prodId: self.sampleData.labels[button.tag].objectForKey("prodId") as! String)
        self.showHistory()
        
        //传递数据存入缓存
        self.cache.cacheSetString("searchkey", value: self.sampleData.labels[button.tag].objectForKey("prodId") as! NSString)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("detail") as UIViewController
        self.navigationController?.showViewController(vc, sender: nil)
    }
    
    // 显示大家都在搜,换一批
    @IBAction func showRecomment() {
        
        // 图标高度
        let keyWorldHeight: CGFloat = 30.0
        let keyWorldY: CGFloat = 40.0
        
        // 第一个标签的起点
        var size = CGSizeMake(8, keyWorldY)
        
        // 间距
        let padding: CGFloat = 15.0
        
        // 圆角
        let cornerRadius: CGFloat = 15.0

        //屏幕宽度
        let width = UIScreen.mainScreen().bounds.size.width - 16
        
        for index in 0 ..< self.sampleData.labels.count {
            var label: NSString = self.sampleData.labels[index].objectForKey("prodName") as! NSString
            if label == "" {
                label = self.sampleData.labels[index].objectForKey("prodName") as! NSString
            }
            var keyWorldWidth: CGFloat = self.getSizeByString(label, font: self.colors.recomment_font.pointSize).width
            if (keyWorldWidth > width) {
                keyWorldWidth = width
            }
            
            if (width - size.width < keyWorldWidth) {
                size.height += keyWorldY
                size.width = 8.0
            }
            
            // 创建labels
            let button: UIButton = UIButton.init(frame: CGRectMake(size.width, size.height - keyWorldY, keyWorldWidth, keyWorldHeight))
            button.titleLabel?.numberOfLines = 0
            button.backgroundColor = self.sampleData.labels_color[random()%7]
            button.setTitleColor(self.colors.main_recomment_fontcolor, forState: UIControlState.Normal)
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
            button.titleLabel?.font = self.colors.recomment_font
            button.setTitle(label as String, forState: UIControlState.Normal)
            self.recommentView.addSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(MainViewController.labelsClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            // 起点 增加
            size.width += keyWorldWidth + padding
        }
    }
}
