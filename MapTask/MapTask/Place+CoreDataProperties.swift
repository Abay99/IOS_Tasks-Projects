//
//  Place+CoreDataProperties.swift
//  MapTask
//
//  Created by Abai Kalikov on 28.03.18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?

}
