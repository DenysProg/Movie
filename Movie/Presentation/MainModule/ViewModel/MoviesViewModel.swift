//
//  MoviesViewModel.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import CoreData
import UIKit

///
protocol MainViewModelDelegateProtocol: NSObjectProtocol {
    func reloadData(sender: MoviesViewModel)
}

protocol MainViewModelProtocol: NSObjectProtocol {
    func retrieveDataFromCoreData()
    func checkData()
    func loadMoviesData()
    func didSelectMovie(indexPath: IndexPath)
    func numbersOfRowsInSection(section: Int) -> Int
    func object(indexPath: IndexPath) -> ResultMovie?
}

final class MoviesViewModel: NSObject, NSFetchedResultsControllerDelegate, MainViewModelProtocol {
    weak var delegate: MainViewModelDelegateProtocol?
    var networkService: NetworkServiceProtocol?
    var coordinator: CoordinatorProtocol?
    private var photoService: PhotoServiceProtocol?
    var model = MoviesModel(results: [])
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private var fetchedResultsController: NSFetchedResultsController<MovieEntity>?

    init(
        networkService: NetworkServiceProtocol,
        coordinator: CoordinatorProtocol,
        photoService: PhotoServiceProtocol?
    ) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.photoService = photoService
    }

    func checkData() {
        loadMoviesData()
    }

    func loadMoviesData() {
        networkService?.getMoviesData(.popular) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movieList):
                self.model.results = movieList.results
                self.delegate?.reloadData(sender: self)
            case let .failure(error):
                UIAlertController()
                    .showAlertWith(title: "Couldn't connect", message: "Please check your internet connetction")
                print("Error processing json data: \(error)")
            }
        }
    }

    func didSelectMovie(indexPath: IndexPath) {
        let movie = object(indexPath: indexPath)
    }

    func numbersOfRowsInSection(section: Int) -> Int {
        model.results.count
    }

    func object(indexPath: IndexPath) -> ResultMovie? {
        model.results[indexPath.row]
    }
    
}
