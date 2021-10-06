//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Misha on 04.10.2021.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var userName: String?
    @NSManaged public var viewCount: Int16
    @NSManaged public var likeCount: Int16
    @NSManaged public var image: Data?
    @NSManaged public var decription: String?

}
