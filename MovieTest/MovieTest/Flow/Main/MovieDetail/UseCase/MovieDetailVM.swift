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
    private let cardsRelay = BehaviorRelay<MovieDetailModel?>(value: nil)
    private let stateRelay = BehaviorRelay<BasicUIState>(value: .loading)
 
    struct Input {
        let typeAndSub: Observable<(String,String)>
    }
    
    struct Output {
        let cards: Driver<MovieDetailModel>
        let state: Driver<BasicUIState>

    }
    
    init(repository: MovieDetailRepository) {
        self.repository = repository
    }
    
    func transform(_ input: Input) -> Output {
        self.makeRequestDetail(input)
        return Output(cards: self.cardsRelay.asDriver(),
                      state: self.stateRelay.asDriver().skip(1))
    }
    
    private func makeRequestDetail(_ input: Input) {
        
    }


}
