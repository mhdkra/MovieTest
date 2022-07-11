//
//  AppCoordinator.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start(with option: DeepLinkOption?) {
        //start with deepLink
        if let option = option {
            self.startWith(deeplink: option)
        } else {
            self.runMainFlow()
        }
    }
    
    private func startWith(deeplink: DeepLinkOption) {
        switch deeplink {
        case .test:
            if let coordinator = childCoordinators.first {
                self.runMainFlow(with: deeplink)
                self.router.dismissModule()
                self.removeDependency(coordinator)
            }
        }
    }
    
    private func runMainFlow(with option: DeepLinkOption? = nil) {
        let coordinator = coordinatorFactory.makeMainCoordinator(router: self.router)
        addDependency(coordinator)
        coordinator.start()
    }
}
