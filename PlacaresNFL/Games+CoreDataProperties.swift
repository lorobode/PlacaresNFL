//
//  Games+CoreDataProperties.swift
//  PlacaresNFL
//
//  Created by Nichollas Fonseca on 12/11/15.
//  Copyright © 2015 Nichollas Fonseca. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Games {

    @NSManaged var year: String?
    @NSManaged var home_team: String?
    @NSManaged var visitor_team: String?
    @NSManaged var home_score: String?
    @NSManaged var visitor_score: String?

}
