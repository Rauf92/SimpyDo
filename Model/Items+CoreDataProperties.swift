//
//  Items+CoreDataProperties.swift
//  SimpyDo
//
//  Created by Rauf Aliyev on 06.01.22.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var itemColor: Int16
    @NSManaged public var itemsName: String?
    @NSManaged public var category: Category?

}

extension Items : Identifiable {

}
