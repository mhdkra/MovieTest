//
//  AppDelegate.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22 .
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = UINavigationController()
        window!.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window!.overrideUserInterfaceStyle = .light
        }
        applicationCoordinator.start()
        return true
    }

    private func makeCoordinator() -> Coordinator {
        return AppCoordinator(
            router: RouterImpl(rootController: self.rootController),
            coordinatorFactory: CoordinatorFactoryImpl()
        )
    }
}

