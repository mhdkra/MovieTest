//
//  MovieDetailVC.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD
import SDWebImage

class MovieDetailVC: UIViewController,MovieDetailView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: MovieDetailVM!
    
    private let disposeBag = DisposeBag()
    private let hud = JGProgressHUD(style: .dark)
    private let idRelay = BehaviorRelay<(Int)>(value: (0))
    
    var model : MovieDetailModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        guard let m = model else{return}
        self.setupView(model: m)
        idRelay.accept(model?.id ?? 0)
        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        let input = MovieDetailVM.Input(id: self.idRelay.asObservable())
        let output = self.viewModel.transform(input)
        
        output.movie.drive { (movie) in
            self.model = movie
            self.setupView(model: self.model)
        }.disposed(by: self.disposeBag)
        
        output.state.drive { (state) in
            switch state {
            case .loading:
                self.hud.show(in: self.view)
            case .close:
                self.hud.dismiss(animated: true)
            case .failure(let message):
                self.showAlert(message: message)
            default: break
            }
        }.disposed(by: self.disposeBag)
    }
    
    private func setupView(model: MovieDetailModel){
        if let url = URL(string: model.movieImage){
            posterImageView?.sd_setImage(with: url, completed: {_,_,_,_ in
                self.view.setNeedsLayout()
            })
        }
        self.overviewTextView.text = model.overview
        self.titleLabel.text = model.title
        self.durationLabel.text = model.duration
        self.genreLabel.text = model.genres.joined(separator: ", ")
        
    }
  
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MovieDetailVC {
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
