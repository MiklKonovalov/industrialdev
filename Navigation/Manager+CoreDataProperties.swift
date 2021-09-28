//
//  Manager+CoreDataProperties.swift
//  
//
//  Created by Misha on 27.09.2021.
//
//

import Foundation
import CoreData


extension Manager {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Manager> {
        return NSFetchRequest<Manager>(entityName: "Manager")
    }

    @NSManaged public var userName: String?

}
