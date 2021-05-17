//
//  CoreDataTests.swift
//  MovieTests
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import CoreData
@testable import Movie
import XCTest

///
final class CoreDataTests: XCTestCase {
    private var coreData: CoreDataProtocol!
    private var cinemaListModel: MoviesInfo?
    private var cinemaModel: [ResultMovie]?

    override func setUp() {
        coreData = CoreData.shareInstance
    }

    func testCoreData() {
        cinemaModel = [ResultMovie()]

        let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

        let context = container?.viewContext ?? NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        coreData?.deleteObjectsfromCoreData(context: context)
        coreData?.saveDataToCoreData(movies: cinemaModel ?? [ResultMovie()], context: context)

        XCTAssert(container != nil)
        XCTAssert(cinemaModel?.count == 1)
        XCTAssert(coreData?.deleteObjectsfromCoreData(context: context) != nil)
        XCTAssert(coreData?.saveDataToCoreData(
            movies: cinemaModel ?? [ResultMovie()],
            context: context
        ) != nil)
    }
}
