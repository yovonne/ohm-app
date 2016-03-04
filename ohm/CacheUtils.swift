//
//  CacheUtils.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/16.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import Foundation

class CacheUtils {
    func cacheSetString(key: String, value: NSString) {
        let userInfo = NSUserDefaults()
        userInfo.setValue(value, forKey: key)
    }
    
    func cacheGetString(key: String) -> NSString {
        let userInfo = NSUserDefaults()
        let value = userInfo.stringForKey(key)
        return value!
    }
}
