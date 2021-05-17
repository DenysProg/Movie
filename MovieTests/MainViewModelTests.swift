//
//  MovieTests.swift
//  MovieTests
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import CoreData
@testable import Movie
import XCTest

///
final class MockNetworkService: NetworkServiceProtocol {
    var movies: [ResultMovie]!
    var image: UIImage!
    var photo: PhotoInfo!

    init() {}

    convenience init(movies: [ResultMovie]) {
        self.init()
        self.movies = movies
    }

    func getMoviesData(_ type: TypeMovie, completion: @escaping (Result<MoviesInfo, Error>) -> Void) {
        if let movies = movies {
            completion(.success(MoviesInfo(results: movies)))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }

    func getPhotoInfo(movieId: Int, completion: @escaping (PhotoInfo?, Error?) -> Void) {
        if let photo = photo {
            completion(photo, nil)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(nil, error)
        }
    }
}

final class MainViewModel: XCTestCase {
    var viewModel: MoviesViewModel!
    var networkService: NetworkServiceProtocol!
    var coordinator: CoordinatorProtocol!
    var movies: [ResultMovie] = []
    var photoService: PhotoServiceProtocol!
    var movieEntity = MovieEntity()
    var catchPhoto: PhotoInfo?
    var photos: PhotoInfo?
    var context: NSManagedObjectContext!
    var assemblyBuilder = AssemblerModuleBuilder()
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    override func setUpWithError() throws {
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDownWithError() throws {
        networkService = nil
        coordinator = nil
        viewModel = nil
    }

    func testGetSuccessMovie() {
        let movie = ResultMovie()
        movies.append(movie)
        networkService = MockNetworkService(movies: movies)
        viewModel = MoviesViewModel(
            networkService: networkService,
            coordinator: coordinator,
            photoService: photoService
        )

        var catchMovies: [ResultMovie]?

        networkService.getMoviesData(.popular) { result in
            switch result {
            case let .success(movie):
                catchMovies = movie.results
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        XCTAssertNotEqual(movies.count, 0)
        XCTAssertEqual(movies.count, catchMovies?.count)

        networkService.getPhotoInfo(movieId: 1) { photo, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let photo = photo {
                self.catchPhoto = photo
            }
        }

        XCTAssertIdentical(photos, catchPhoto)
        XCTAssertNil(photos)
    }
}
