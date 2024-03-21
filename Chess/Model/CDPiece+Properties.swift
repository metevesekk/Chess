//
//  CDPiece+Properties.swift
//  Chess
//
//  Created by Mete Vesek on 21.03.2024.
//
import CoreData

extension CDPiece {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPiece> {
        return NSFetchRequest<CDPiece>(entityName: "CDPiece")
    }

}
