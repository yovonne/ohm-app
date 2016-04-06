//
//  UserInfoEntity+CoreDataProperties.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/4/6.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserInfoEntity {

    @NSManaged var uid: String?
    @NSManaged var access_token: String?
    @NSManaged var refresh_token: String?
    @NSManaged var screen_name: String?
    @NSManaged var profile_image_url: String?
    @NSManaged var login_type: String?

}
