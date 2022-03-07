//
//  MoviesViewController.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 07/03/22.
//

import Foundation

import UIKit

class MoviesViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewDidLoad()
        print("oiii1")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        title = "Movies"
        print("oiii2")
    }
}
