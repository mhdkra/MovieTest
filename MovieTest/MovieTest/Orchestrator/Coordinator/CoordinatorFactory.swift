//
//  CoordinatorFactory.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation
import UIKit

protocol CoordinatorFactory {
    // MARK: - Main
    func makeMainCoordinator(router: Router) -> Coordinator & MainCoordinatorOutput
}
