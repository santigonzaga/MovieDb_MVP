//
//  ListMoviesPresenter.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 04/03/22.
//

import UIKit

protocol ShowDetailsPresenterDelegate: AnyObject {
    func fetched(genres: [Genre])
}

class ShowDetailsPresenter {
    weak var view: (UIViewController & ShowDetailsPresenterDelegate)?
    
    init () {}
    
    func getGenresId() {
        WebService.get(path: Constants.GENRE_PATH, type: GenreResult.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.dismiss(animated: true)
                switch result {
                case .success(let genreResult):
                    self?.view?.fetched(genres: genreResult.genres)
                    break
                case .failure:
                    self?.view?.presentAlert(message: "Error")
                    break
                }
            }
        }
    }
    
}
