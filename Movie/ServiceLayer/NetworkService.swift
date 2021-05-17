//
//  NetworkService.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getMoviesData(_ type: TypeMovie, completion: @escaping (Result<MoviesInfo, Error>) -> Void)
    func getPhotoInfo(movieId: Int, completion: @escaping (PhotoInfo?, Error?) -> Void)
}

///
final class NetworkService: NetworkServiceProtocol {
    private var url = "https://api.themoviedb.org"

    func getMoviesData(_ type: TypeMovie, completion: @escaping (Result<MoviesInfo, Error>) -> Void) {
        let urlString =
            "\(url)/3/movie/\(type.rawValue)?api_key=\(apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data")
                return
            }

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)

            do {
                let jsonData = try JSONDecoder().decode(MoviesInfo.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    print(jsonData)
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
