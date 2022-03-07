//
//  ListMoviesPresenter.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 04/03/22.
//

import UIKit

protocol ListMoviesPresenterDelegate: AnyObject {
    func fetchedPopularMovies(movies: [Movie])
    func fetchedNowPlayingMovies(movies: [Movie])
}

class ListMoviesPresenter {
    weak var view: (UIViewController & ListMoviesPresenterDelegate)?
    
    init () {}
    
    func getPopularMovies(isRefreshing: Bool = false) {
        DispatchQueue.main.async {
            if !isRefreshing {
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
            } else {
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
            }
        }
    }
    
    func getNowPlayingMovies() {
        
        WebService.get(path: Constants.NOW_PLAYING_PATH, type: MovieResult.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.dismiss(animated: true)
                switch result {
                case .success(let movieResult):
                    self?.view?.fetchedNowPlayingMovies(movies: movieResult.results)
                    break
                case .failure:
                    self?.view?.presentAlert(message: "Error")
                    break
                }
            }
        }
    }
}
