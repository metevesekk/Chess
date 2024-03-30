//
//  CDBoard+CoreDataProperties.swift
//  Chess
//
//  Created by Mete Vesek on 30.03.2024.
//

//
//  CDPiece+CoreDataClass.swift
//  Chess
//
//  Created by Mete Vesek on 21.03.2024.
//

import Foundation
import CoreData

@objc(CDBoard)
public class CDBoard: NSManagedObject {

    @NSManaged public var pieces: Data

    
}
