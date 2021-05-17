//
//  Photo.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import Foundation

///
final class PhotoInfo: Decodable {
    let id: Int
    let backdrops, posters: [Backdrop]
}

///
final class Backdrop: Codable {
    dynamic var filePath = ""

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
