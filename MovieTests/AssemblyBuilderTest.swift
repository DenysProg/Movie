//
//  AssemblyBuilderTest.swift
//  MovieTests
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

@testable import Movie
import XCTest

final class AssemblyBuilderTest: XCTestCase {
    private var assemblyBuilder: AssemblerBuilderProtocol?
    private var coordinator: CoordinatorProtocol!
    private var cinemaModel: ResultMovie?
    private var navController = UINavigationController()

    func testAssemblyBuilder() {
        cinemaModel = ResultMovie()

        let mainVC = assemblyBuilder?.createDetailModule(
            movie: cinemaModel,
            coordinator: coordinator
        )
        let detailVC = assemblyBuilder?.createMainModule(coordinator: coordinator)

        XCTAssert(cinemaModel != nil)
        XCTAssert(mainVC == detailVC)
        XCTAssert(assemblyBuilder?.createMainModule(coordinator: coordinator) == nil)
        XCTAssert(assemblyBuilder?.createDetailModule(
            movie: cinemaModel,
            coordinator: coordinator
        ) == nil)
    }
}
