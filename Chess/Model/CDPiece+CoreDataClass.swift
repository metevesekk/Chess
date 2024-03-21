//
//  CDPiece+CoreDataClass.swift
//  Chess
//
//  Created by Mete Vesek on 21.03.2024.
//

import Foundation
import CoreData

@objc(CDPiece)
public class CDPiece: NSManagedObject {

    @NSManaged public var color: String
    @NSManaged public var type: String
    @NSManaged public var isAlive: Bool
    @NSManaged public var indexPath: Data
    @NSManaged public var moveCount: Int16
    
}
