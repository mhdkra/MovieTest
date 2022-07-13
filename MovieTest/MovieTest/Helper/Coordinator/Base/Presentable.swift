//
//  Presentable.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation
import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}
