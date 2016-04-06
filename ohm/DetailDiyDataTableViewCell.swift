//
//  DetailDiyDataTableViewCell.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/3/28.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class DetailDiyDataTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var showAllButton: UIButton!
    @IBOutlet weak var addButton:UIButton!
    
    // container view 高度的优先级约束
    @IBOutlet weak var containerViewHeightLayoutConstrain:NSLayoutConstraint!
    
    // container view相对于superview的bottom约束
    @IBOutlet weak var containerViewBottomLayoutConstrain:NSLayoutConstraint!
    
    // 展开收起
    typealias ExpandClosure = () -> Void
    var expandClosure:ExpandClosure?
    
    // 添加
    typealias AddInfo = () -> Void
    var addInfo:AddInfo?
    
    // 是否显示"收起"按钮
    let isShowCollapse:Bool = true
    
    // 重设高度
    var constrainViewHeight: CGFloat? {
        didSet{
            containerViewHeightLayoutConstrain.constant = constrainViewHeight!
        }
    }
    
    // 收起或展开操作
    var expanded:Bool? {
        didSet{
            if !expanded! {
                // 收起操作
                showAllButton.hidden = false
                showAllButton.setTitle("展开", forState: .Normal)
                showAllButton.setImage(UIImage(named: "down"), forState: .Normal)
            }else{
                // 展开操作
                showAllButton.setTitle("收起", forState: .Normal)
                showAllButton.setImage(UIImage(named: "up"), forState: .Normal)
                if !isShowCollapse {
                    showAllButton.hidden = true
                }
            }
        }
    }
    
    // 是否可以收缩
    var isExpandable : Bool? {
        didSet{
            if !isExpandable! {
                showAllButton.hidden = true
            }else{
                showAllButton.hidden = false
            }
        }
    }
    
    @IBAction func didClickExpandOrCollapse(){
        if expandClosure != nil {
            expandClosure!()
        }
    }
    
    @IBAction func didClickAddInfo(){
        if addInfo != nil {
            addInfo!()
        }
    }
}
