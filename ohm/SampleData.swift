//
//  SampleData.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/18.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import Foundation
import SwiftyJSON

class SampleData {
    
    // 用户经验
    let userexp: Int = 270
    
    // 广告
    let adData: [NSDictionary] = [
        ["title":"Cloupor","adImage":"ad1-logo.png","url":"http://www.cloupor.com/"],
        ["title":"aspire","adImage":"ad2-logo.png","url":"http://www.aspirecig.com/"],
        ["title":"KangerTech","adImage":"ad3-logo.png","url":"http://www.kangeronline.com/"],
        ["title":"Coil Master","adImage":"ad4-logo.png","url":"http://www.coil-master.net/"]
    ]
    
    // 大家都在搜
    let labels: [NSDictionary] = [
        ["prodId":"P0003","prodName":"拖船 V.2","prodEName":"Tug Boat V.2"],
        ["prodId":"P0004","prodName":"面纱2.5 ","prodEName":"Plume Veil V2.5"],
        ["prodId":"P0005","prodName":"肯尼迪V4","prodEName":"KENNEDY V4"],
        ["prodId":"P0006","prodName":"高塔铃铛","prodEName":"Rig Mod Roughneck V2 "],
        ["prodId":"P0007","prodName":"绝对零度","prodEName":"Subzero Competition"]
//        ,["prodId":"P0008","prodName":"流浪汉 V3.1","prodEName":"HOBO V3.1"],
//        ["prodId":"P0009","prodName":"创世纪起源Og2","prodEName":"Origen Genesis V2 MKII "],
//        ["prodId":"P00010","prodName":"大力神","prodEName":"THE BIG DRIPPER V2"],
//        ["prodId":"P00011","prodName":"鲨鱼涡轮","prodEName":"Vortice"]
    ]
    let labels_color: [UIColor] = [UIColor(red: 118/255, green: 139/255, blue: 190/255, alpha: 1),
        UIColor(red: 216/255, green: 127/255, blue: 158/255, alpha: 1),
        UIColor(red: 112/255, green: 189/255, blue: 198/255, alpha: 1),
        UIColor(red: 229/255, green: 158/255, blue: 47/255, alpha: 1),
        UIColor(red: 194/255, green: 133/255, blue: 214/255, alpha: 1),
        UIColor(red: 54/255, green: 188/255, blue: 107/255, alpha: 1),
        UIColor(red: 215/255, green: 148/255, blue: 112/255, alpha: 1)
    ]
    
    let data: [NSDictionary] = [
            ["prodId":"P0003","prodName":"拖船 V.2","prodEName":"Tug Boat V.2"],
            ["prodId":"P0004","prodName":"面纱2.5 ","prodEName":"Plume Veil V2.5"],
            ["prodId":"P0005","prodName":"肯尼迪V4","prodEName":"KENNEDY V4"],
            ["prodId":"P0006","prodName":"高塔铃铛","prodEName":"Rig Mod Roughneck V2 "],
            ["prodId":"P0007","prodName":"绝对零度","prodEName":"Subzero Competition"]
//            ,["prodId":"P0008","prodName":"流浪汉 V3.1","prodEName":"HOBO V3.1"],
//            ["prodId":"P0009","prodName":"创世纪起源Og2","prodEName":"Origen Genesis V2 MKII "],
//            ["prodId":"P00010","prodName":"大力神","prodEName":"THE BIG DRIPPER V2"],
//            ["prodId":"P00011","prodName":"鲨鱼涡轮","prodEName":"Vortice"],
//            ["prodId":"P00012","prodName":"","prodEName":"MAKO"],
//            ["prodId":"P00013","prodName":"","prodEName":"CARTEL CASCATA"],
//            ["prodId":"P00014","prodName":"恶性蚂蚁","prodEName":"radius "],
//            ["prodId":"P00015","prodName":"","prodEName":"Nectar Nano "],
//            ["prodId":"P00016","prodName":"","prodEName":"Cubix RDA Cosmic Innovations"],
//            ["prodId":"P00017","prodName":"元素","prodEName":"Elementmod Stumpy"],
//            ["prodId":"P00018","prodName":"","prodEName":"Origen Dripper V3"],
//            ["prodId":"P00019","prodName":"闪电","prodEName":"Praxis Derringer"],
//            ["prodId":"P00020","prodName":"圣杯3","prodEName":"Chalice III "],
//            ["prodId":"P00021","prodName":"","prodEName":"Boss Hog"],
//            ["prodId":"P00022","prodName":"舢板","prodEName":"Dinghy "]
    ]
    
    // 标题
    let detail_titles:[[String]] = [
        ["image","",""],
        ["客观数据","1",""],
        ["雾化器名称","2","prodName"],
        ["英文名称","2","prodEName"],
        ["类型","2","prodType"],
        ["支持配件","2","parts"],
        ["内阻","2","ohm"],
        ["主观数据","1",""],
        ["diy数据","3","diyData"],
        ["diy难度","2","diyDifficult"],
        ["diy视频","2","diyVideo"],
        ["稀有度（在售/停售/限量）","2","unusualRate"],
        ["支持者信息","1",""],
        ["","2","dataOwner"]
    ]
    
    let detailDiyData: [NSDictionary] = [
        ["prodId":"P0003","diyData":["22G-3.0-5","22G-3.0-6","22G-3.0-7","24G-3.0-6","24G-3.0-7"]],
        ["prodId":"P0004","diyData":["22G-3.0-5","22G-3.0-6","22G-3.0-7","24G-3.0-6","24G-3.0-7"]],
        ["prodId":"P0005","diyData":["24G双丝并饶-3.5-5"]],
        ["prodId":"P0006","diyData":[]],
        ["prodId":"P0007","diyData":["22G-3.0-5","22G-3.0-6"]]
    ]
    
    
    let detailData: [NSDictionary] = [
            ["image":"product-sample1.png","prodId":"P0003","prodName":"拖船 V.2","prodEName":"Tug Boat V.2","prodType":"滴油","parts":"短舱,大进气滴嘴,510接口滴嘴","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
            ["image":"product-sample2.png","prodId":"P0004","prodName":"面纱2.5 ","prodEName":"Plume Veil V2.5","prodType":"滴油","parts":"510接口滴嘴,可替换上仓滴嘴","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"停售","parc":"","dataOwner":"数据由陈弢提供"],
            ["image":"product-sample3.png","prodId":"P0005","prodName":"肯尼迪V4","prodEName":"KENNEDY V4","prodType":"滴油","parts":"玻璃仓,短仓,彩仓","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G双丝并饶-3.5-5","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
            ["image":"product-sample4.png","prodId":"P0006","prodName":"高塔铃铛","prodEName":"Rig Mod Roughneck V2 ","prodType":"滴油","parts":"510通用接口","ohm":"可忽略","diyData":"可忽略","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
            ["image":"product-sample5.png","prodId":"P0007","prodName":"绝对零度","prodEName":"Subzero Competition","prodType":"滴油","parts":"雾化器上盖","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"]
//            ,["image":"product-sample.png","prodId":"P0008","prodName":"流浪汉 V3.1","prodEName":"HOBO V3.1","prodType":"滴油","parts":"510滴嘴","ohm":"轻微","diyData":"24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
//            ["image":"product-sample.png","prodId":"P0009","prodName":"创世纪起源Og2","prodEName":"Origen Genesis V2 MKII ","prodType":"滴油","parts":"510滴嘴","ohm":"可忽略","diyData":"24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
//            ["image":"product-sample.png","prodId":"P00010","prodName":"大力神","prodEName":"THE BIG DRIPPER V2","prodType":"滴油","parts":"","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
//            ["image":"product-sample.png","prodId":"P00011","prodName":"鲨鱼涡轮 ","prodEName":"Vortice","prodType":"滴油","parts":"短仓","ohm":"可忽略","diyData":"22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
//            ["image":"product-sample.png","prodId":"P00012","prodName":"","prodEName":"MAKO","prodType":"滴油","parts":"上盖,510滴嘴","ohm":"可忽略","diyData":"24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由陈弢提供"],
//            ["image":"product-sample.png","prodId":"P00013","prodName":"","prodEName":"CARTEL CASCATA","prodType":"滴油","parts":"大进气滴嘴,510接口滴嘴","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00014","prodName":"恶性蚂蚁","prodEName":"radius ","prodType":"滴油","parts":"短舱,大进气滴嘴,510接口滴嘴","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00015","prodName":"","prodEName":"Nectar Nano ","prodType":"滴油","parts":"短舱,大进气滴嘴,510接口滴嘴","ohm":"可忽略","diyData":"24G-3.0-6","diyDifficult":"Ω Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00016","prodName":"","prodEName":"Cubix RDA Cosmic Innovations","prodType":"滴油","parts":"短舱,大进气滴嘴,510接口滴嘴","ohm":"可忽略","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00017","prodName":"元素","prodEName":"Elementmod Stumpy","prodType":"滴油","parts":"短舱,大进气滴嘴,510接口滴嘴","ohm":"可忽略","diyData":"24G-3.0-6","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00018","prodName":"","prodEName":"Origen Dripper V3","prodType":"滴油","parts":"大进气滴嘴,510接口滴嘴","ohm":"可忽略","diyData":"24G-3.0-6","diyDifficult":"Ω Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00019","prodName":"闪电","prodEName":"Praxis Derringer","prodType":"滴油","parts":"短舱,大进气滴嘴,510接口滴嘴","ohm":"","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00020","prodName":"圣杯3","prodEName":"Chalice III ","prodType":"滴油","parts":"510接口滴嘴","ohm":"","diyData":"24G-3.0-6","diyDifficult":"Ω Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00021","prodName":"","prodEName":"Boss Hog","prodType":"滴油","parts":"大进气滴嘴,510接口滴嘴","ohm":"","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"],
//            ["image":"product-sample.png","prodId":"P00022","prodName":"舢板","prodEName":"Dinghy ","prodType":"滴油","parts":"短舱,大进气滴嘴,510接口滴嘴","ohm":"","diyData":"22G-3.0-5,22G-3.0-6,22G-3.0-7,24G-3.0-6,24G-3.0-7","diyDifficult":"Ω Ω Ω","diyVideo":"","unusualRate":"在售","parc":"","dataOwner":"数据由闻喆提供"]
    ]
    
    func getDetailProductInfo(prodId: String) -> NSDictionary {
        var product_info: NSDictionary = NSDictionary()
        for info in self.detailData {
            if info.objectForKey("prodId") as? NSString == prodId {
                product_info = info
                break
            }
        }
        return product_info
    }
    
    func getDetailProductDiyInfo(prodId: String) -> NSDictionary {
        var diy_info: NSDictionary = NSDictionary()
        for info in self.detailDiyData {
            if info.objectForKey("prodId") as? NSString == prodId {
                diy_info = info
                break
            }
        }
        return diy_info
    }

}
