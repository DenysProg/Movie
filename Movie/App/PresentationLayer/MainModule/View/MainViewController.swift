//
//  ViewController.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import CoreData
import UIKit

///
final class MainViewController: UIViewController, StoryboardedCoordinator {
    @IBOutlet var tableView: UITableView!

    var viewModel: MoviesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.delegate = self
        setNavigationBar()
        loadData()
    }

    private func loadData() {
        viewModel?.checkData()
    }

    private func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.topItem?.title = "Movies"
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numbersOfRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = viewModel?.object(indexPath: indexPath)

        if let movieCell = cell as? MovieTableViewCell {
            if let movie = object {
                movieCell.delegate = self
                movieCell.setCellWithValuesOf(movie)
            }
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectMovie(indexPath: indexPath)
    }
}

extension MainViewController: MainViewModelDelegateProtocol {
    func reloadData(sender: MoviesViewModel) {
        tableView.reloadData()
    }
}

extension MainViewController: MovieTableViewCellDelegate {
    func getImage(byPath: String, completion: @escaping (UIImage) -> ()) {
        viewModel?.getImage(path: byPath) { image in
            completion(image)
        }
    }
}
