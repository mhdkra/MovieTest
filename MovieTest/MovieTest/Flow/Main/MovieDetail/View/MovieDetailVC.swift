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
    var viewModel: MovieDetailVM!
    var id: Int!
    
    private let disposeBag = DisposeBag()
    private let hud = JGProgressHUD(style: .dark)
    private let idRelay = BehaviorRelay<(String)>(value: (""))
    
    var movie : MovieDetailModel? {
        didSet{
           
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        idRelay.accept("\(id)")
        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        let input = MovieDetailVM.Input(id: self.idRelay.asObservable())
        let output = self.viewModel.transform(input)
        
        output.movie.drive { (movie) in
            self.movie = movie
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
