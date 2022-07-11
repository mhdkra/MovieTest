//
//  Router.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

protocol Router: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, isWrapNavigation: Bool)
    func present(_ module: Presentable?, mode: PresentMode)
    func present(_ module: Presentable?, animated: Bool, mode: PresentMode, isWrapNavigation: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, animated: Bool, hideBar: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    func setRootModule(_ module: Presentable?, hideBar: Bool, animation: RouterImpl.Animation)
    
    func popToRootModule(animated: Bool)
}

enum PresentMode {
    case overContext
    case fullScreen
    case basic
}
