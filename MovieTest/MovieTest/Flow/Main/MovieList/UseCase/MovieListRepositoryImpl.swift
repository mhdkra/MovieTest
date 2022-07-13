//
//  MovieListRepositoryImpl.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import RxSwift

class MovieListRepositoryImpl: MovieListRepository {
    private let movieListAPI: MovieListAPI
    private let genresAPI: GenresAPI
    private let disposeBag = DisposeBag()
    
    init(movieListAPI: MovieListAPI, genresAPI: GenresAPI) {
        self.movieListAPI = movieListAPI
        self.genresAPI = genresAPI
    }
    
    func request(body: MovieListBody) -> Single<([MovieModel])> {
        return Single.create { (observer) in
            
            self.movieListAPI
                .request(parameters: body.dictionary ?? [String: Any]())
                .map { self.outputTransformModel($0) }
                .subscribe { (result) in
                    switch result {
                    case .success(let model):
                        observer(.success(model))
                    case .failure(let error):
                        observer(.failure(error))
                    }
                } onFailure: { (error) in
                    observer(.failure(error))
                }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    private func outputTransformModel(_ response: MovieListResponse) -> Result<[MovieModel], HTTPError> {
        if let datas = response.results {
            let model = datas.map { (res) in
                return MovieModel(id: res.id ?? 0, name: res.originalTitle ?? "", release: res.releaseDate ?? "", genres: res.genreIds ?? [], imageUrl: "https://www.themoviedb.org/t/p/w500\(res.posterPath ?? "")")
            }
            return .success(model)
        }
        return .failure(HTTPError.internalError)
    }
    
    func requestGenres(body: BaseBody) -> Single<([Genre])>{
        return Single.create { (observer) in
            
            self.genresAPI
                .request(parameters: body.dictionary ?? [String: Any]())
                .map { self.outputTransformModelGenre($0) }
                .subscribe { (result) in
                    switch result {
                    case .success(let model):
                        observer(.success(model))
                    case .failure(let error):
                        observer(.failure(error))
                    }
                } onFailure: { (error) in
                    observer(.failure(error))
                }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    private func outputTransformModelGenre(_ response: GenreResponse) -> Result<[Genre], HTTPError> {
        if response.statusMessage != nil{
            return .failure(HTTPError.internalError)
        }
        return .success(response.genres ?? [])
    }
}

