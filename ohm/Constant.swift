//
//  Constant.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/19.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import Foundation

//com.sina.weibo.SNWeiboSDKDemo
let kAppKey = "1190104810"
let kAppSecret = "90454bcb2d9799670d5a4339a77ce32e"
let kRedirectURI = "https://api.weibo.com/oauth2/default.html"

//微博请求地址
let wb_users_show = "https://api.weibo.com/2/users/show.json"
let wb_access_token = "https://api.weibo.com/oauth2/access_token"
let wb_get_token_info = "https://api.weibo.com/oauth2/get_token_info"

//微博请求区分
enum WBRequestFlag {
    case Init
    case UsersShow
    case AccessToken
    case CheckAccessToken
}

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
