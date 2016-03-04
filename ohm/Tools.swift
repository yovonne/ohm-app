//TODO: //
//  Tools.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/18.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import Foundation
import UIKit

// 图片缩放
func resizeImage(image:UIImage, ratio: CGFloat) -> UIImage {
    let newSize: CGSize = CGSizeMake(image.size.width*ratio, image.size.height*ratio)
    let rect = CGRectMake(0, 0, newSize.width, newSize.height)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.drawInRect(rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}
