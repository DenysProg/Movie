//
//  MainCoordinator.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController? { get set }

    func start()
    func detailSubscription(movie: ResultMovie?)
}

///
final class MainCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?


    func start() {
        if let navigationController = navigationController {
           
            navigationController.pushViewController(mainViewController, animated: false)
        }
    }

}
