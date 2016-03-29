//
//  ADScrollView.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/18.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class ADScrollView : UIScrollView {
    
    let sampleData: SampleData = SampleData()
    
    private struct PrefsStruct {
        static var adButtons: [UIButton]! = [UIButton]()
    }
    
    class var adButtons : [UIButton]! {
        get { return PrefsStruct.adButtons }
    }
    
    func showAd(superview: UIView, bottomLayoutGuide: UILayoutSupport, topviews: [UIView]) {
        //屏幕尺寸
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height

        self.frame = CGRect(x: 0, y: screenHeight - 64 - 60, width: screenWidth, height: 60)
        superview.addSubview(self)
        for c in superview.constraints {
            if c.identifier == "adbottom" {
                superview.removeConstraint(c)
            }
        }
//        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 60))
        superview.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        superview.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: superview, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
//        superview.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        for topview in topviews {
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: topview, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        }
        
        showAdLabels()
    }
    
    // 显示广告
    func showAdLabels() {
        
        //屏幕宽度
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        // 间距
        let padding: CGFloat = 10.0
        
        // 屏幕显示广告个数
        let adCount: CGFloat = 2.0
        
        // ad尺寸
        let adLabelWidth: CGFloat = (screenWidth - padding * (1.0 + adCount)) / adCount
        let adLabelHeight: CGFloat = 40.0

        // 计算内容宽度
        var contentSize = CGSizeMake(((adLabelWidth + padding) * CGFloat(Float(sampleData.adData.count)) + padding), adLabelHeight + padding * 2)
        if contentSize.width < screenWidth {
            contentSize = CGSizeMake(screenWidth, adLabelHeight + padding * 2)
        }
        
        self.contentSize = contentSize
        
        // 第一个标签的起点
        var size = CGSizeMake(padding, padding)
        
        for index in 0 ..< sampleData.adData.count {
            
            // 创建labels
            let button: UIButton = UIButton(frame: CGRectMake(size.width, size.height, adLabelWidth, adLabelHeight))
            button.backgroundColor = UIColor.whiteColor()
            button.setImage(UIImage(named: sampleData.adData[index].objectForKey("adImage") as! String), forState: UIControlState.Normal)
            button.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            button.adjustsImageWhenDisabled = false // 禁用模式下按钮不会变暗
            button.adjustsImageWhenHighlighted = false // 触摸模式下按钮不会变暗
            self.addSubview(button)
            button.tag = index
            
            // 起点 增加
            size.width += adLabelWidth + padding
            
            PrefsStruct.adButtons!.append(button)
        }
    }
}
