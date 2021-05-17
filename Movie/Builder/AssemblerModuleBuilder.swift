//
//  AssemblerModuleBuilder.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import Foundation
import UIKit

///
protocol AssemblerBuilderProtocol {
    func createMainModule(coordinator: CoordinatorProtocol) -> UIViewController

}

final class AssemblerModuleBuilder: AssemblerBuilderProtocol {
    func createMainModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let networkService = NetworkService()
        let photoServise = PhotoService()
        let vc = MainViewController.instantiate()
        vc.viewModel = MoviesViewModel(
            networkService: networkService,
            coordinator: coordinator,
            photoService: photoServise
        )
        vc.viewModel?.coordinator = coordinator
        vc.viewModel?.delegate = vc
        return vc
    }
}
