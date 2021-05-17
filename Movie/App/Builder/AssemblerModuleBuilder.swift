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
    func createDetailModule(movie: ResultMovie?, coordinator: CoordinatorProtocol) -> UIViewController
}

final class AssemblerModuleBuilder: AssemblerBuilderProtocol {
    func createMainModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let networkService = NetworkService()
        let photoServise = PhotoService()
        let mainVC = MainViewController.instantiate()
        mainVC.viewModel = MoviesViewModel(
            networkService: networkService,
            coordinator: coordinator,
            photoService: photoServise
        )
        mainVC.viewModel?.delegate = mainVC
        return mainVC
    }

    func createDetailModule(movie: ResultMovie?, coordinator: CoordinatorProtocol) -> UIViewController {
        let networkService = NetworkService()
        let photoServise = PhotoService()
        let vc = DetailViewController.instantiate()
        vc.viewModel = DetailViewModel(
            movieDetails: movie,
            networkService: networkService,
            photoService: photoServise,
            coordinator: coordinator
        )
        return vc
    }
}
