//
//  Coordinator.swift
//  MovieTests
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

@testable import Movie
import XCTest

///
final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

///Mark
final class CoordinatorTest: XCTestCase {
    var coordinator: MainCoordinator!
    var navigationController = MockNavigationController()
    var assemblyBuilder = AssemblerModuleBuilder()

    override func setUpWithError() throws {
        coordinator = MainCoordinator(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDownWithError() throws {
        coordinator = nil
    }

    func testRouter() {
        coordinator.detailSubscription(movie: nil)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
    }
}
