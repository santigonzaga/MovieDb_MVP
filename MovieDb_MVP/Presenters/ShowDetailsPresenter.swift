//
//  ListMoviesPresenter.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 04/03/22.
//

import UIKit

protocol ShowDetailsPresenterDelegate: AnyObject {
    func fetched(movie: Movie)
}

class ShowDetailsPresenter {
    weak var view: (UIViewController & ListMoviesPresenterDelegate)?
    
    init () {}
    
    
    func getNowPlayingMovies() {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen(completion: {
                WebService.get(path: Constants.NOW_PLAYING_PATH, type: [Movie].self) { [weak self] result in
                    DispatchQueue.main.async {
                        self?.view?.dismiss(animated: true)
                        switch result {
                        case .success(let movies):
                            // self?.view?.fetched(movies: movies)
                            break
                        case .failure:
                            self?.view?.presentAlert(message: "Error")
                            break
                        }
                    }
                }
            })
        }
    }
}
