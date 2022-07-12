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
    private var page = 1
    private var keyword = ""
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
        self.makeRequestSearch(input)
        return Output(cards: self.cardsRelay.asDriver().skip(1),
                      state: self.stateRelay.asDriver().skip(1))
    }
    
    private func makeRequestSearch(_ input: Input) {
        input
            .keyword
            .subscribe { (key) in
                self.keyword = key.element ?? ""
                self.requestMovies(keyword: self.keyword)
            }.disposed(by: self.disposeBag)
    }

    private func makeRequestLoadMoreCards(_ input: Input) {
        input
            .loadMoreRelay
            .subscribe { (_) in
                self.page = self.page + 1
                self.requestMovies(keyword: self.keyword)
            }.disposed(by: self.disposeBag)
    }
    
    private func requestMovies(keyword: String) {
        self.repository
            .request(parameters: MovieListBody(apiKey: HTTPAuth.shared.apiKey, query: keyword ?? "", page: self.page))
            .subscribe { (result) in
                if self.page != 1 {
                    self.stateRelay.accept(.close)
                }else{
                    self.stateRelay.accept(.close)
                    self.stateRelay.accept(.stopLoadMore)
                }
                self.cardsRelay.accept(result)
            } onFailure: { (error) in
                self.stateRelay.accept(.failure(error.readableError))
            }.disposed(by: self.disposeBag)
    }

}
