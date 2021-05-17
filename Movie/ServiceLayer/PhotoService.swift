//
//  PhotoService.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import UIKit

protocol PhotoServiceProtocol {
    func saveImageToCatch(urlString: String, image: UIImage)
    func getImageFromCache(urlString: String) -> UIImage?
    func loadPhoto(by urlString: String, completion: @escaping (UIImage?) -> ())
    func photo(by urlString: String, completion: @escaping (UIImage?) -> ())
}

final class PhotoService: PhotoServiceProtocol {
    
    private var images = [String: UIImage]()
    private let cacheLifeTime: TimeInterval = 60 * 60 * 24 * 7

    private static let pathName: String = {
        let pathName = "images"

        guard let cacheDir = FileManager.default.urls(
            for: FileManager.SearchPathDirectory.cachesDirectory,
            in: .userDomainMask
        ).first else { return pathName }
        let url = cacheDir.appendingPathComponent(pathName, isDirectory: true)

        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    func saveImageToCatch(urlString: String, image: UIImage) {
        <#code#>
    }
    
    func getImageFromCache(urlString: String) -> UIImage? {
        <#code#>
    }
    
    func loadPhoto(by urlString: String, completion: @escaping (UIImage?) -> ()) {
        <#code#>
    }
    
    func photo(by urlString: String, completion: @escaping (UIImage?) -> ()) {
        <#code#>
    }
    
}
