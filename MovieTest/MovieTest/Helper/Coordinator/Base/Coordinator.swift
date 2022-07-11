//
//  Coordinator.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}
