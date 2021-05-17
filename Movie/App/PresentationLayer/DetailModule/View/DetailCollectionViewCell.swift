//
//  DetailCollectionViewCell.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import UIKit

///
final class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet var movieImage: UIImageView!

    func setMovie(_ movie: UIImage) {
        movieImage.image = movie
    }
}
