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
    
}
