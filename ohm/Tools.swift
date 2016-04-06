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

/* 电阻计算
 * @param
 *    p1000    材料电阻率(Ω*mm/m)
 *    n        圈数
 *    d        发热丝直径(mm)
 *    D1       绕圈内径(mm)
 *    parallel 1:单发 2:双发
 * @return  
 *    发热丝电阻
 */
func calcR(p1000: NSDecimalNumber, n: NSDecimalNumber, d: NSDecimalNumber, D1: NSDecimalNumber, parallel: NSDecimalNumber) -> NSDecimalNumber {
    let p: NSDecimalNumber = p1000.decimalNumberByDividingBy(NSDecimalNumber(string: "1000"))
    let K: NSDecimalNumber = NSDecimalNumber(string: "0")
    let Pi: NSDecimalNumber = NSDecimalNumber(string: "3.141592654")
    let D2: NSDecimalNumber = D1.decimalNumberByAdding(d).decimalNumberByAdding(d)
    
    var L: NSDecimalNumber = D1.decimalNumberByAdding(D2)
    L = L.decimalNumberByDividingBy(NSDecimalNumber(string: "2"))
    L = L.decimalNumberByMultiplyingBy(n)
    L = L.decimalNumberByMultiplyingBy(Pi)
    L = L.decimalNumberByAdding(K)
    
    var S: NSDecimalNumber = d.decimalNumberByDividingBy(NSDecimalNumber(string: "2"))
    S = S.decimalNumberByMultiplyingBy(S)
    S = S.decimalNumberByMultiplyingBy(Pi)
    
    var R: NSDecimalNumber = L.decimalNumberByDividingBy(S)
    R = p.decimalNumberByMultiplyingBy(R)
    R = R.decimalNumberByDividingBy(parallel)
    return R
}

/* 功率计算
 * @param
 *    batteryV 电池电压(V)
 *    R        发热丝电阻(ohm)
 * @return
 *    雾化器功率(W)
 */
func calcP(batteryV: NSDecimalNumber, R: NSDecimalNumber) -> NSDecimalNumber {
    let powerdec: NSDecimalNumber = batteryV.decimalNumberByMultiplyingBy(batteryV).decimalNumberByDividingBy(R)
    return powerdec
}
