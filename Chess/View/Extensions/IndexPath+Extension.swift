//
//  IndexPathExtension.swift
//  Chess
//
//  Created by Mete Vesek on 21.03.2024.
//

import Foundation

extension IndexPath {
    func archive() -> Data{
        return try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }

    static func unarchive(data: Data) -> IndexPath? {
           do {
               return try NSKeyedUnarchiver.unarchivedObject(ofClass: NSIndexPath.self, from: data) as IndexPath?
           } catch {
               return nil
           }
       }
}
