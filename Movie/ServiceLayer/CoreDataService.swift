//
//  CoreDataService.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import CoreData
import UIKit

protocol CoreDataProtocol: AnyObject {
    func saveDataOf(movie: [ResultMovie])
    func deleteObjectsfromCoreData(context: NSManagedObjectContext)
    func saveDataToCoreData(movies: [ResultMovie], context: NSManagedObjectContext)
}

///
final class CoreData: CoreDataProtocol {
    static let shareInstance = CoreData()
    private init() {}
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")


    func saveDataToCoreData(movies: [ResultMovie], context: NSManagedObjectContext) {
        context.perform {
            for movie in movies {
                let movieEntity = MovieEntity(context: context)
                movieEntity.title = movie.title
                movieEntity.year = movie.year
                guard let rate = movie.rate else { return }
                movieEntity.rate = String(rate)
                movieEntity.posterImage = movie.posterImage
                movieEntity.backdropImage = movie.backdropImage
                movieEntity.overview = movie.overview
                guard let idInt = movie.id else { return }
                movieEntity.id = Int64(idInt)
            }
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
