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

    init(navigationController: UINavigationController, assemblyBuilder: AssemblerBuilderProtocol)

    func start()
}

///
final class MainCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblerBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func start() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(coordinator: self) else { return }
            navigationController.pushViewController(mainViewController, animated: false)
        }
    }
}
