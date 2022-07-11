//
//  MainCoordinator.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    private let router: Router
    private let factory: MainFactory
    
    init(router: Router, factory: MainFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        self.showMovieList()
    }
    
    private func showMovieList() {
        let view = factory.makeMovieListView()
        view.onCardTapped = { [weak self] (movie) in
            guard let self = self else { return }
            self.showMovieDetail(movie: movie)
        }
        router.setRootModule(view, hideBar: false, animation: .bottomUp)
    }
    
    private func showMovieDetail(movie: MovieModel) {
        var view = factory.makeMovieDetailView()
        view.onCardTapped = { [weak self] (movie) in
            guard let self = self else { return }
            view = self.factory.makeMovieDetailView()
            self.router.push(view)
        }
        router.push(view)
    }
}
