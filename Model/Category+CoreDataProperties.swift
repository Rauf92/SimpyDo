//
//  Category+CoreDataProperties.swift
//  SimpyDo
//
//  Created by Rauf Aliyev on 06.01.22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var parentCategory: NSSet?

}

// MARK: Generated accessors for parentCategory
extension Category {

    @objc(addParentCategoryObject:)
    @NSManaged public func addToParentCategory(_ value: Items)

    @objc(removeParentCategoryObject:)
    @NSManaged public func removeFromParentCategory(_ value: Items)

    @objc(addParentCategory:)
    @NSManaged public func addToParentCategory(_ values: NSSet)

    @objc(removeParentCategory:)
    @NSManaged public func removeFromParentCategory(_ values: NSSet)

}

extension Category : Identifiable {

}
