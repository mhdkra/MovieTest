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
    private let moviesRelay = BehaviorRelay<[MovieModel]>(value: [])
    private let genressRelay = BehaviorRelay<[Genre]>(value: [])
    private let stateRelay = BehaviorRelay<BasicUIState>(value: .loading)
    private var page = 1
    private var keyword = ""
    
    static var getAllGenres: [Genre] {
        if let objects = UserDefaults.standard.value(forKey: "genres") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Genre] {
                return objectsDecoded
            } else {
                return []
            }
        } else {
            return []
        }
    }
    
    struct Input {
        let viewDidLoadRelay: Observable<Void>
        let loadMoreRelay: Observable<Void>
        let keyword: Observable<String>
    }
    
    struct Output {
        let movies: Driver<[MovieModel]>
        let genres: Driver<[Genre]>
        let state: Driver<BasicUIState>
    }
    
    init(repository: MovieListRepository) {
        self.repository = repository
    }
    
    
    func transform(_ input: Input) -> Output {
        self.makeRequestGenres(input)
        self.makeRequestSearch(input)
        self.makeRequestSearchLoadmore(input)
        return Output(movies: self.moviesRelay.asDriver().skip(1),
                      genres: self.genressRelay.asDriver().skip(1),
                      state: self.stateRelay.asDriver().skip(1))
    }
    
    private func makeRequestGenres(_ input: Input) {
        input
            .viewDidLoadRelay
            .subscribe { (key) in
                self.requestGenres()
            }.disposed(by: self.disposeBag)
    }
    
    private func makeRequestSearch(_ input: Input) {
        input
            .keyword
            .subscribe { (key) in
                self.keyword = key.element ?? ""
                self.requestMovies(keyword: self.keyword)
            }.disposed(by: self.disposeBag)
    }
    
    private func makeRequestSearchLoadmore(_ input: Input) {
        input
            .loadMoreRelay
            .subscribe { (key) in
                self.page = self.page + 1
                self.requestMoviesLoadmore(keyword: self.keyword)
            }.disposed(by: self.disposeBag)
    }
    
    private func requestMovies(keyword: String) {
        self.repository
            .request(body: MovieListBody(api_key: HTTPAuth.shared.apiKey, query: keyword, page: self.page))
            .subscribe { (result) in
                self.moviesRelay.accept(result)
                self.stateRelay.accept(.close)
                
            } onFailure: { (error) in
                self.stateRelay.accept(.failure(error.readableError))
            }.disposed(by: self.disposeBag)
    }
    
    private func requestMoviesLoadmore(keyword: String) {
        self.repository
            .request(body: MovieListBody(api_key: HTTPAuth.shared.apiKey, query: keyword, page: self.page))
            .subscribe { (result) in
                let collect = self.moviesRelay.value + result
                self.moviesRelay.accept(collect)
                self.stateRelay.accept(.stopLoadMore)
                
            } onFailure: { (error) in
                self.stateRelay.accept(.failure(error.readableError))
            }.disposed(by: self.disposeBag)
    }
    
    private func requestGenres() {
        self.repository
            .requestGenres(body: BaseBody(api_key: HTTPAuth.shared.apiKey))
            .subscribe { (result) in
                self.genressRelay.accept(MovieListVM.getAllGenres)
                self.stateRelay.accept(.close)
                self.stateRelay.accept(.stopLoadMore)
            } onFailure: { (error) in
                self.genressRelay.accept(MovieListVM.getAllGenres)
                self.stateRelay.accept(.failure(error.readableError))
            }.disposed(by: self.disposeBag)
    }
}
