//
//  CoreDataDao.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/19.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import Foundation
import CoreData

class CoreDataDao {
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func deleteUserInfo() {
        let context = delegate.managedObjectContext
        do {
            let request = NSFetchRequest(entityName: "UserInfoEntity")
            let userInfoEntitys = try context.executeFetchRequest(request)
            if userInfoEntitys.count > 0 {
                for one in userInfoEntitys {
                    context.deleteObject(one as! NSManagedObject)
                }
                try context.save()
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
    }
    
    //编辑我的信息
    func addorupdateUserInfo(userInfo: NSDictionary) {
        let context = delegate.managedObjectContext
        do {
            let access_token = userInfo.objectForKey("access_token") as! String
            let profile_image_url = userInfo.objectForKey("profile_image_url") as! String
            let refresh_token = userInfo.objectForKey("refresh_token") as! String
            let screen_name = userInfo.objectForKey("screen_name") as! String
            let uid = userInfo.objectForKey("uid") as! String
            
            let request = NSFetchRequest(entityName: "UserInfoEntity")

            let userInfoEntitys = try context.executeFetchRequest(request)
            if userInfoEntitys.count > 0 {
                for one in userInfoEntitys {
                    let userInfoEntity: UserInfoEntity = one as! UserInfoEntity
                    userInfoEntity.access_token = access_token
                    userInfoEntity.profile_image_url = profile_image_url
                    userInfoEntity.refresh_token = refresh_token
                    userInfoEntity.screen_name = screen_name
                    userInfoEntity.uid = uid
                    userInfoEntity.login_type = "Weibo"
                }
                
            } else {
                let userInfoEntitys = NSEntityDescription.entityForName("UserInfoEntity", inManagedObjectContext: context)
                
                let userInfoEntity = UserInfoEntity(entity: userInfoEntitys!, insertIntoManagedObjectContext: context)

                userInfoEntity.access_token = access_token
                userInfoEntity.profile_image_url = profile_image_url
                userInfoEntity.refresh_token = refresh_token
                userInfoEntity.screen_name = screen_name
                userInfoEntity.uid = uid
                userInfoEntity.login_type = "Weibo"
            }
            
            try context.save()
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
    }
    
    //查询我的信息
    func searchUserInfo() -> NSDictionary? {
        let context = delegate.managedObjectContext
        var result: NSDictionary?
        do {
            let request = NSFetchRequest(entityName: "UserInfoEntity")
            let userInfoEntitys = try context.executeFetchRequest(request)
            if userInfoEntitys.count > 0 {
                for one in userInfoEntitys {
                    let userInfo = one as! UserInfoEntity
                    result = NSDictionary()
                    result = [
                        "access_token": userInfo.access_token!,
                        "profile_image_url": userInfo.profile_image_url!,
                        "refresh_token": userInfo.refresh_token!,
                        "screen_name": userInfo.screen_name!,
                        "uid": userInfo.uid!
                    ]
                }
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
        return result
    }
    
    //我要认证
    func updateMyProductsAuthentication(prodId: String, authentication: Bool) {
        let context = delegate.managedObjectContext
        do {
            let request = NSFetchRequest(entityName: "MyProductEntity")
            let predicate:NSPredicate = NSPredicate(format: "prodId = %@", prodId)
            request.predicate = predicate
            let productEntity = try context.executeFetchRequest(request)
            if productEntity.count > 0 {
                for one in productEntity {
                    let product: MyProductEntity = one as! MyProductEntity
                    product.authentication = authentication
                }
                try context.save()
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
    }
    
    // 查询我的雾化器
    func searchMyProducts() ->[NSDictionary]{
        let context = delegate.managedObjectContext
        var result: [NSDictionary] = [NSDictionary]()
        do {
            let request = NSFetchRequest(entityName: "MyProductEntity")
            let productEntity = try context.executeFetchRequest(request)
            for one in productEntity {
                let product = one as! MyProductEntity
                let prodId = product.prodId
                result.append([
                    "prodId":prodId!,
                    "authentication": product.authentication
                ])
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
        return result
    }
    
    func isExistMyProduct(prodId: String) ->Bool{
        let context = delegate.managedObjectContext
        var result: Bool = false
        do {
            let request = NSFetchRequest(entityName: "MyProductEntity")
            let predicate:NSPredicate = NSPredicate(format: "prodId = %@", prodId)
            request.predicate = predicate
            let productEntity = try context.executeFetchRequest(request)
            if productEntity.count > 0 {
                result = true
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
        return result
    }
    
    func deleteMyProduct(prodId: String) {
        let context = delegate.managedObjectContext
        do {
            let request = NSFetchRequest(entityName: "MyProductEntity")
            let predicate:NSPredicate = NSPredicate(format: "prodId = %@", prodId)
            request.predicate = predicate
            let productEntity = try context.executeFetchRequest(request)
            if productEntity.count > 0 {
                for one in productEntity {
                    context.deleteObject(one as! NSManagedObject)
                }
                try context.save()
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
    }
    
    // 添加我的雾化器
    func addMyProduct(prodInfo: NSDictionary) {
        let context = delegate.managedObjectContext
        do {
            let prodId = prodInfo.objectForKey("prodId") as! String
            let request1 = NSFetchRequest(entityName: "MyProductEntity")
            let predicate:NSPredicate = NSPredicate(format: "prodId = %@", prodId)
            request1.predicate = predicate
            let productEntitys1 = try context.executeFetchRequest(request1)
            
            if productEntitys1.count == 0 {
                let productEntity2 = NSEntityDescription.entityForName("MyProductEntity", inManagedObjectContext: context)
                
                let product = MyProductEntity(entity: productEntity2!, insertIntoManagedObjectContext: context)
                
                var name = prodInfo.objectForKey("prodName") as! String
                if name == "" {
                    name = prodInfo.objectForKey("prodEName") as! String
                }
                product.prodId = prodId
                product.name = name
                product.authentication = false
                
                try context.save()
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
    }
    
    // 查询所有历史记录 true 正序 false 倒序
    func searchHistory(ascending: Bool) ->[NSDictionary]{
        let context = delegate.managedObjectContext
        var result: [NSDictionary] = [NSDictionary]()
        do {
            let request = NSFetchRequest(entityName: "SearchHistoryEntity")
            let sort = NSSortDescriptor(key: "search_time", ascending: ascending)
            request.sortDescriptors = [sort]
            let historyEntity = try context.executeFetchRequest(request)
            for one in historyEntity {
                let history = one as? SearchHistoryEntity
                result.append(["prodId":history!.prodId!,"prodName":history!.name!])
            }
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
        return result
    }
    
    //添加历史记录
    func addHistory(name: String, prodId: String) {
        let context = delegate.managedObjectContext
        do {
            let request1 = NSFetchRequest(entityName: "SearchHistoryEntity")
            let predicate:NSPredicate = NSPredicate(format: "name = %@", name)
            request1.predicate = predicate
            let historyEntitys1 = try context.executeFetchRequest(request1)
            
            if historyEntitys1.count == 0 {
                // 没有历史记录，确认总历史记录数是否为12
                let request2 = NSFetchRequest(entityName: "SearchHistoryEntity")
                let sort = NSSortDescriptor(key: "search_time", ascending: true)
                request2.sortDescriptors = [sort]
                let historyEntitys2 = try context.executeFetchRequest(request2)
                
                // 记录数为12则删除最早的一条
                if historyEntitys2.count == 12 {
                    context.deleteObject(historyEntitys2.first as! NSManagedObject)
                }
                try context.save()
                
                // 插入新记录
                let historyEntity2 = NSEntityDescription.entityForName("SearchHistoryEntity", inManagedObjectContext: context)
                
                let history = SearchHistoryEntity(entity: historyEntity2!, insertIntoManagedObjectContext: context)
                
                history.prodId  = prodId
                history.name = name
                history.search_time = NSDate()
            } else {
                // 有历史记录，更新搜索时间
                for one in historyEntitys1 {
                    let history: SearchHistoryEntity = one as! SearchHistoryEntity
                    history.search_time = NSDate()
                }
            }
            
            try context.save()
            
        } catch let err as NSError {
            NSLog("Error %@", err)
        }
    }
}
