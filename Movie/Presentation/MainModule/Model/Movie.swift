//
//  Movie.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import Foundation

///
enum TypeMovie: String {
    case latest
    case playing = "now_playing"
    case popular
    case topRated = "top_rated"
    case upcoming
}

///
struct MoviesInfo: Decodable {
    let results: [ResultMovie]
}

///
struct ResultMovie: Decodable {
    var overview: String? = ""
    var rate: Double? = 0
    var title: String? = ""
    var posterImage: String? = ""
    var year: String? = ""
    var backdropImage: String? = ""
    var id: Int? = 0

    enum CodingKeys: String, CodingKey {
        case rate = "vote_average"
        case posterImage = "poster_path"
        case year = "release_date"
        case title, overview
        case id
        case backdropImage = "backdrop_path"
    }

    init() {}

    init(movie: MovieEntity) {
        self.init()
        title = movie.title
        year = movie.year
        rate = Double(movie.rate ?? "0")
        posterImage = movie.posterImage
        backdropImage = movie.backdropImage
        overview = movie.overview
        id = Int(movie.id)
    }
}
