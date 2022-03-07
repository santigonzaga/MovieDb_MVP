//
//  ListMoviesPresenter.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 04/03/22.
//

import UIKit

protocol ListMoviesPresenterDelegate: AnyObject {
    func fetchedPopularMovies(movies: [Movie])
}

class ListMoviesPresenter {
    weak var view: (UIViewController & ListMoviesPresenterDelegate)?
    
    init () {}
    
    func getPopularMovies() {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen(completion: {
                WebService.get(path: Constants.POPULAR_PATH, type: MovieResult.self) { [weak self] result in
                    DispatchQueue.main.async {
                        self?.view?.dismiss(animated: true)
                        switch result {
                        case .success(let movieResult):
                            self?.view?.fetchedPopularMovies(movies: movieResult.results)
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
    
    func getNowPlayingMovies() {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen(completion: {
                WebService.get(path: Constants.NOW_PLAYING_PATH, type: MovieResult.self) { [weak self] result in
                    DispatchQueue.main.async {
                        self?.view?.dismiss(animated: true)
                        switch result {
                        case .success(let movies):
                            //self?.view?.fetched(movies: movies)
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
