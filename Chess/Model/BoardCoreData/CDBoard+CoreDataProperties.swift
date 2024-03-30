//
//  CDBoard+CoreDataClass.swift
//  Chess
//
//  Created by Mete Vesek on 30.03.2024.
//
import Foundation
import CoreData

@objc(CDPiece)
public class CDBoard: NSManagedObject {

   
    @NSManaged public var pieces: Data
    
}
