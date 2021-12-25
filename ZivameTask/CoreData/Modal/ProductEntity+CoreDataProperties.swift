//
//  ProductEntity+CoreDataProperties.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 25/12/21.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var imageAtrbt: String?
    @NSManaged public var nameAtrbt: String?
    @NSManaged public var priceAtrbt: String?
    @NSManaged public var ratingAtrbt: Int64

}
