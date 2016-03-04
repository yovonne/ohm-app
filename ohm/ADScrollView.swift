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
        
        // 第一个标签的起点
        var size = CGSizeMake(padding, padding)
        
        var contentSize = CGSizeMake(screenWidth, adLabelHeight + padding * 2)
        
        for var index = 0; index < sampleData.adData.count; index++ {
            
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
            
            // 计算内容宽度
            if (size.width > contentSize.width) {
                contentSize.width = size.width
            }
            
            PrefsStruct.adButtons!.append(button)
        }
        
        self.contentSize = contentSize
    }
}
