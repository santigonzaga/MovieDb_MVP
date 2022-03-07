//
//  MainCoordinator.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 07/03/22.
//

import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?

    func eventOccurred(with type: CoordinatorEvent) {

    }

    func start() {
        let vc = MoviesViewController()
        vc.coordinator = self

        navigationController?.setViewControllers([vc], animated: true)
    }
}
