//
//  MoviesViewModel.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import UIKit

///
protocol MainViewModelDelegateProtocol: NSObjectProtocol {
    func reloadData(sender: MoviesViewModel)
}

protocol MainViewModelProtocol: NSObjectProtocol {
    func retrieveDataFromCoreData()
    func checkData()
    func loadMoviesData()
    func didSelectMovie(indexPath: IndexPath)
    func numbersOfRowsInSection(section: Int) -> Int
    func object(indexPath: IndexPath) -> ResultMovie?
}

class MoviesViewModel: NSObject, MainViewModelProtocol {
    func retrieveDataFromCoreData() {
        <#code#>
    }
    
    func checkData() {
        <#code#>
    }
    
    func loadMoviesData() {
        <#code#>
    }
    
    func didSelectMovie(indexPath: IndexPath) {
        <#code#>
    }
    
    func numbersOfRowsInSection(section: Int) -> Int {
        <#code#>
    }
    
    func object(indexPath: IndexPath) -> ResultMovie? {
        <#code#>
    }
    
}
