//
//  MovieDetailVM.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailVM: BaseViewModel {
    
    private let repository: MovieDetailRepository
    private let disposeBag = DisposeBag()
    private let detailRelay = BehaviorRelay<MovieDetailModel?>(value: nil)
    private let castRelay = BehaviorRelay<[CastModel]>(value: [])
    private let stateRelay = BehaviorRelay<BasicUIState>(value: .loading)
    struct Input {
        let id: Observable<(Int)>
    }
    
    struct Output {
        let movie: Driver<MovieDetailModel?>
        let casts: Driver<[CastModel]>
        let state: Driver<BasicUIState>

    }
    
    init(repository: MovieDetailRepository) {
        self.repository = repository
    }
    
    func transform(_ input: Input) -> Output {
        self.makeRequestDetail(input)
        self.makeRequestCast(input)
        return Output(movie: self.detailRelay.asDriver().skip(1),
                      casts: self.castRelay.asDriver().skip(1),
                    state: self.stateRelay.asDriver().skip(1))
    }
    
    private func makeRequestDetail(_ input: Input) {
        input
            .id
            .subscribe { (id) in
                self.requestDetail(id: id)
            }.disposed(by: self.disposeBag)
    }
    
    private func makeRequestCast(_ input: Input) {
        input
            .id
            .subscribe { (id) in
                self.requestCast(id: id)
            }.disposed(by: self.disposeBag)
    }
    
    private func requestDetail(id: Int) {
        self.repository
            .requestDetail(id: id)
            .subscribe { (result) in
                self.stateRelay.accept(.close)
                self.detailRelay.accept(result)
            } onFailure: { (error) in
                self.stateRelay.accept(.failure(error.readableError))
            }.disposed(by: self.disposeBag)
    }
    
    private func requestCast(id: Int) {
        self.repository
            .requestCasts(id: id)
            .subscribe { (result) in
                self.stateRelay.accept(.close)
                self.stateRelay.accept(.stopLoadMore)
                self.castRelay.accept(result)
            } onFailure: { (error) in
                self.stateRelay.accept(.failure(error.readableError))
            }.disposed(by: self.disposeBag)
    }
    

}
