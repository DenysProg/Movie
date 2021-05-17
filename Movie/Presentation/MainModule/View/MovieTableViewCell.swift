//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func getImage(byPath: String, completion: @escaping (UIImage) -> ())
}

///
final class MovieTableViewCell: UITableViewCell {
    @IBOutlet private var titleLable: UILabel!
    @IBOutlet private var movieImage: UIImageView!
    @IBOutlet private var descriptLabel: UILabel!
    @IBOutlet private var rateMovieLabel: UILabel!
    
    weak var delegate: MovieTableViewCellDelegate?

    func setCellWithValuesOf(_ movie: ResultMovie) {
        updateUI(title: movie.title, rate: "\(movie.rate ?? 0)", overview: movie.overview, image: movie.backdropImage)
        delegate?.getImage(byPath: movie.backdropImage ?? "") { [weak self] image in
            self?.movieImage.image = image
        }
        viewsAttributes()
    }
   
    private func updateUI(
        title: String?,
        rate: String?,
        overview: String?,
        image: String?
    ) {
        titleLable.text = title
        descriptLabel.text = overview
        rateMovieLabel.text = rate
    }
    
    private func viewsAttributes() {
        movieImage.layer.cornerRadius = 20
        movieImage.layer.borderWidth = 0.8
        movieImage.layer.borderColor = UIColor.black.cgColor
        movieImage.contentMode = .scaleAspectFill

        rateMovieLabel.layer.masksToBounds = true
        rateMovieLabel.layer.cornerRadius = 15
    }

}
