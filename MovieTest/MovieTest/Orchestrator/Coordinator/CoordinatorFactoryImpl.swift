//
//  CoordinatorFactoryImpl.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation
import UIKit

class CoordinatorFactoryImpl: CoordinatorFactory {
    
    // MARK: - Authentication
    func makeMainCoordinator(router: Router) -> MainCoordinatorOutput & Coordinator {
        return MainCoordinator(router: router, factory: ModuleFactoryImpl())
    }
    
    func makeMainCoordinator(navController: UINavigationController?) -> (configurator: Coordinator & MainCoordinatorOutput, toPresent: Presentable?) {
        let router = self.router(navController)
        let coordinator = MainCoordinator(router: router, factory: ModuleFactoryImpl())
        return (coordinator, router)
    }
    
    func makeMainCoordinator() -> (configurator: Coordinator & MainCoordinatorOutput, toPresent: Presentable?) {
        return makeMainCoordinator(navController: nil)
    }
    
    //--------------------------------------------------------------------------------------------------
    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImpl(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController {
            return navController
        } else {
            return UINavigationController.controllerFromStoryboard(.main)
        }
    }
    
}
