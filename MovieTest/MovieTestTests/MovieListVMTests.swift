//
//  MovieListVMTests.swift
//  MovieTestTests
//
//  Created by Tiara Mahardika on 13/07/22.
//

@testable import MovieTest
import RxSwift
import XCTest
import RxBlocking
import RxTest

class MovieListVMTests: XCTestCase {
    
    private let disposeBag = DisposeBag()

    func test_transform_showsCorrectOutput() {
        let repository = MovieListRepositoryStub(
            movies: [
                MovieModel(
                    id: 0,
                    name: "any-keyword",
                    release: "any",
                    genres: [1],
                    imageUrl: "any",
                    overview: "any"
                )
            ],
            genres: [ Genre(id: 1, name: "any genre") ]
        )
        let sut = MovieListVM(repository: repository)
        
        
        let output = sut.transform(
            MovieListVM.Input(
                viewDidLoadRelay: .just(()),
                loadMoreRelay: .just(()),
                keyword: .just("any-keyword")
            )
        )
        
        // FIXME: I don't know why the it gives `Sequence timeout` error.
        // When debug, the self.genressRelay.accept(MovieListVM.getAllGenres) called,
        // it should triggers return Output(...), but in the test side,
        // this become unfinished stream (limit with timeout become `Sequence timeout` error.
        let genresResult = output.genres.toBlocking(timeout: 0.5).materialize()
        switch genresResult {
        case let .completed(genres):
            XCTAssertTrue(!genres.isEmpty)
        case let .failed(genres, error):
            XCTFail("Expect success, got error: \(error) instead, with elements: \(genres)")
        }
    }
    
    // MARK: - Helpers
    
    private class MovieListRepositoryStub: MovieListRepository {
        private let movies: [MovieModel]
        private let genres: [Genre]
        
        init(movies: [MovieModel], genres: [Genre]) {
            self.movies = movies
            self.genres = genres
        }
        
        func request(body: MovieListBody) -> Single<([MovieModel])> {
            .just(movies)
        }
        
        func requestGenres(body: BaseBody) -> Single<([Genre])> {
            .just(genres)
        }
    }
}

