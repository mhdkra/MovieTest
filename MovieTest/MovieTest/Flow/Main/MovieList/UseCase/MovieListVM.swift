//
//  MovieListVM.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListVM: BaseViewModel {

    
    private let repository: MovieListRepository
    private let disposeBag = DisposeBag()
    private let cardsRelay = BehaviorRelay<[MovieModel]>(value: [])
    private let stateRelay = BehaviorRelay<BasicUIState>(value: .loading)
    
    struct Input {
        let viewDidLoadRelay: Observable<Void>
        let loadMoreRelay: Observable<Void>
        let keyword: Observable<String>
    }
    
    struct Output {
        let movies: Driver<[MovieModel]>
        let state: Driver<BasicUIState>

    }
    
    init(repository: MovieListRepository) {
        self.repository = repository
    }
    
    func transform(_ input: Input) -> Output {
        <#code#>
    }
}
