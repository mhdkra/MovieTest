//
//  MovieListVC.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD
import SDWebImage
import ESPullToRefresh

class MovieListVC: UIViewController, MovieListView {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MovieListVM!
    var onCardTapped: ((MovieModel) -> Void)?
    
    private var movies = [MovieModel]()
    private let hud = JGProgressHUD(style: .dark)
    private let disposeBag = DisposeBag()
    private let viewDidLoadRelay = PublishRelay<Void>()
    private let loadMoreRelay = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupCollectionView()
        self.viewDidLoadRelay.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    func bindViewModel() {
        let input = MovieListVM.Input(viewDidLoadRelay: self.viewDidLoadRelay.asObservable(),
                                     loadMoreRelay: self.loadMoreRelay.asObservable(),
                                     keyword: self.searchBar.rx.text.orEmpty.asObservable())
                                     
        let output = self.viewModel.transform(input)
        
        output.movies.drive { (movies) in
            self.movies = movies
            self.tableView.reloadData()
        }.disposed(by: self.disposeBag)
        
        output.state.drive { (state) in
            switch state {
            case .loading:
                self.showLoading()
            case .close:
                self.hideLoading()
            case .failure(let message):
                self.showAlert(message: message)
            case .success(let message):
                self.showAlert(message: message, isSuccess: true)
            case .stopLoadMore:
                self.tableView.es.stopLoadingMore()
            case .stopRefresh:
                self.tableView.es.stopPullToRefresh()
            default: break
            }
        }.disposed(by: self.disposeBag)
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupSearchBar(){
        searchBar.placeholder = "Search"
    }
    
    private func setupCollectionView(){
        tableView.registerCell(type: MovieCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
             withType: MovieCell.self,
             for: indexPath) as? MovieCell else {
                  return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = self.movies[indexPath.row]
        onCardTapped?(target)
    }

}

extension MovieListVC {
    private func showLoading() {
        hud.show(in: self.view)
    }
    
    private func hideLoading() {
        hud.dismiss(animated: true)
    }
    
    private func showAlert(message: String, isSuccess: Bool = false) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.hud.indicatorView = nil
            self.hud.textLabel.font = .systemFont(ofSize: 21)
            self.hud.textLabel.text = message
            if isSuccess {
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            } else {
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            }
            self.hud.dismiss(afterDelay: 1.0)
        }
    }
}
