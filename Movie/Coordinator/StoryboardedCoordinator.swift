//
//  StoryboardedCoordinator.swift
//  Movie
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import Foundation
import UIKit

///
protocol StoryboardedCoordinator {
    static func instantiate() -> Self
}

extension StoryboardedCoordinator where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: id) as? Self else {
            fatalError()
        }
        return viewController
    }
}
