//
//  Constant.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/19.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import Foundation

// 左菜单
let menu_options: [NSDictionary] = [
    ["title":"我的雾化器","storyboardId":"side2"],
    ["title":"我的任务","storyboardId":""],
    ["title":"关于我们","storyboardId":""],
    ["title":"数据及设备支持","storyboardId":""]
]

// 等级经验
let lvexps: [Int] = [0, 10, 30, 90, 270, 810]

// 材料电阻率
let pickdata:[NSDictionary] = [
    ["name":"kanthal A-1","ohm":NSDecimalNumber(string: "1.45")],
    ["name":"kanthal A","ohm":NSDecimalNumber(string: "1.39")],
    ["name":"kanthal D","ohm":NSDecimalNumber(string: "1.35")],
    ["name":"NiCr","ohm":NSDecimalNumber(string: "1.08")],
    ["name":"Inox 316L","ohm":NSDecimalNumber(string: "0.75")],
    ["name":"Variable","ohm":NSDecimalNumber(string: "1.00")]
]
