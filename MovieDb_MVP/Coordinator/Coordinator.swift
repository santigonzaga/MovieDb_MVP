//
//  Coordinator.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 07/03/22.
//

import UIKit

enum CoordinatorEvent {

}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func eventOccurred(with type: CoordinatorEvent)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
    static func instantiate() -> Self
}

extension Coordinating where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)

        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)

        return storyboard.instantiateInitialViewController() as! Self
    }
}
