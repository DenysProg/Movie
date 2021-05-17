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
    
    private func getFilePath(urlString: String) -> String? {
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }

        let hashName = String(describing: urlString.hashValue)
        return cacheDir.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }

    func saveImageToCatch(urlString: String, image: UIImage) {
        guard let filename = getFilePath(urlString: urlString) else { return }

        let data = image.pngData()
        FileManager.default.createFile(atPath: filename, contents: data, attributes: nil)
    }

    func getImageFromCache(urlString: String) -> UIImage? {
        guard let filename = getFilePath(urlString: urlString),
              let info = try? FileManager.default.attributesOfItem(atPath: filename),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }
        let lifetime = Date().timeIntervalSince(modificationDate)

        guard lifetime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: filename) else { return nil }

        images[urlString] = image

        return image
    }
    
    func loadPhoto(by urlString: String, completion: @escaping (UIImage?) -> ()) {
        let url = imageUrlConstant + urlString
        print(url)
        guard let urlFromString = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlFromString) { data, response, error in
            print("This is \(Thread.current)")
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                print("No data")
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)

            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.images[urlString] = image
            self.saveImageToCatch(urlString: urlString, image: image)
            completion(image)
        }.resume()
    }

    func photo(by urlString: String, completion: @escaping (UIImage?) -> ()) {
        if let photo = images[urlString] {
            completion(photo)
            return
        } else if let photo = getImageFromCache(urlString: urlString) {
            completion(photo)
            return
        } else {
            loadPhoto(by: urlString) { image in
                completion(image)
            }
        }
    }
    
}
