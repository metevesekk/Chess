//
//  CDBoard+CoreDataProperties.swift
//  Chess
//
//  Created by Mete Vesek on 30.03.2024.
//

import CoreData

extension CDBoard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBoard> {
        return NSFetchRequest<CDBoard>(entityName: "CDBoard")
    }

}

