//
//  LoadingView.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/18.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class LoadingView: UIImageView {
    
    func create() {
        var imgs: [UIImage]! = []
        for var index = 0; index < 17; index++ {
            let img: UIImage = UIImage(named: String(format: "loading-%d", index+1))!
            imgs.append(img)
        }
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.contentMode = UIViewContentMode.Center
        self.animationImages = imgs
        self.animationDuration = 2
        self.animationRepeatCount = 0
        self.hidden = true
        self.userInteractionEnabled = true
    }
    
    func startLoading() {
        self.hidden = false
        self.startAnimating()
    }
    
    func stopLoading() {
        self.hidden = true
        self.stopAnimating()
    }
    
}
