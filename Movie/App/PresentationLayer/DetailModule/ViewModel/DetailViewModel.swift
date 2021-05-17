//
//  DetailViewModel.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import UIKit

protocol DetailViewModelDelegateProtocol: AnyObject {
    func reloadData()
}

protocol DetailViewModelProtocol: AnyObject {
    init(
        movieDetails: ResultMovie?,
        networkService: NetworkServiceProtocol,
        photoService: PhotoServiceProtocol?,
        coordinator: CoordinatorProtocol?
    )
    func numbersOfRowsInSection(section: Int) -> Int
    func object(indexPath: IndexPath) -> UIImage?
    func showPosters(movieId: Int)
}

///
final class DetailViewModel: DetailViewModelProtocol {
    let networkService: NetworkServiceProtocol!
    var photoService: PhotoServiceProtocol?
    var imageArray: [Backdrop] = []
    var imageDataArray: [UIImage] = []
    var viewModel: DetailViewModel?
    var coordinator: CoordinatorProtocol?
    weak var delegate: DetailViewModelDelegateProtocol?
    let movieDetails: ResultMovie?

    let title: String?
    let rate: String?
    let year: String?
    let overview: String?

    init(
        movieDetails: ResultMovie?,
        networkService: NetworkServiceProtocol,
        photoService: PhotoServiceProtocol?,
        coordinator: CoordinatorProtocol?
    ) {
        self.movieDetails = movieDetails
        title = movieDetails?.title
        rate = "\(movieDetails?.rate ?? 0)"
        year = movieDetails?.year
        overview = movieDetails?.overview

        self.networkService = networkService
        self.photoService = photoService
        showPosters(movieId: movieDetails?.id ?? 0)
    }

    func showPosters(movieId: Int) {
        networkService.getPhotoInfo(movieId: movieId) { [weak self] data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let photo = data, let self = self {
                self.imageArray = Array(photo.backdrops.prefix(3))
                self.showPhoto()
            }
        }
    }

    private func showPhoto() {
        let group = DispatchGroup()
        for photoString in imageArray {
            group.enter()
            let urlString = "https://image.tmdb.org/t/p/original" + photoString.filePath
            photoService?.photo(by: urlString, completion: { image in
                if let image = image {
                    self.imageDataArray.append(image)
                } else {
                    let image = UIImage(systemName: "xmark")
                    self.imageDataArray.append(image ?? UIImage())
                }
                group.leave()
            })
        }
        group.notify(queue: .main) {
            self.delegate?.reloadData()
        }
    }

    func numbersOfRowsInSection(section: Int) -> Int {
        imageDataArray.count
    }

    func object(indexPath: IndexPath) -> UIImage? {
        imageDataArray[indexPath.row]
    }
}
