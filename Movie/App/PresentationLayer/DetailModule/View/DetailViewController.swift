//
//  DetailViewController.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import UIKit

///
class DetailViewController: UIViewController, StoryboardedCoordinator {
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieRate: UILabel!
    @IBOutlet var movieReleaseDate: UILabel!
    @IBOutlet var movieOverview: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!

    var viewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        updateUI()
        viewModel?.delegate = self
    }

    private func updateUI() {
        movieTitle.text = viewModel?.title
        movieRate.text = viewModel?.rate
        movieReleaseDate.text = viewModel?.year
        movieOverview.text = viewModel?.overview

        movieRate.layer.masksToBounds = true
        movieRate.layer.cornerRadius = 15
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numbersOfRowsInSection(section: section) ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DetailCell",
            for: indexPath
        ) as? DetailCollectionViewCell,
            let object = viewModel?.object(indexPath: indexPath)
        else { return UICollectionViewCell() }
        cell.setMovie(object)
        return cell
    }
}

extension DetailViewController: DetailViewModelDelegateProtocol {
    func reloadData() {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
