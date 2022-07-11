//
//  NSObject+Extensions.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
