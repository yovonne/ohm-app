//
//  MyProductEntity+CoreDataProperties.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/19.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MyProductEntity {

    @NSManaged var prodId: String?
    @NSManaged var name: String?
    @NSManaged var authentication: Bool

}
