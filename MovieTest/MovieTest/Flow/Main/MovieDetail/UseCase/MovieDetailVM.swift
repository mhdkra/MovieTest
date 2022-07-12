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
    private let stateRelay = BehaviorRelay<BasicUIState>(value: .loading)
 
    struct Input {
        let id: Observable<(String)>
    }
    
    struct Output {
//        let movie: Driver<MovieDetailModel>
        let state: Driver<BasicUIState>

    }
    
    init(repository: MovieDetailRepository) {
        self.repository = repository
    }
    
    func transform(_ input: Input) -> Output {
        self.makeRequestDetail(input)
        return Output(//movie: self.detailRelay.asDriver().skip(1),
                      state: self.stateRelay.asDriver().skip(1))
    }
    
    private func makeRequestDetail(_ input: Input) {
        
    }


}
