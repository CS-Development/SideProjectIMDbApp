//
//  SearchViewRouter.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import UIKit
import IMDbApiModule

class SearchViewRouter: SearchViewRouting {
    
    var navigationController: UINavigationController?

    func routeToMovieDetails(for movie: SearchResult) {
        let vc = IMDbAppDependencies.shared.makeMovieDetailsViewController(for: movie.id )
        navigationController?.pushViewController(vc, animated: true)
    }
}
