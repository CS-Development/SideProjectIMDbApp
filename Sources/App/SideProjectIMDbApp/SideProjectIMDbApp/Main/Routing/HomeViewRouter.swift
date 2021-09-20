//
//  HomeViewRouter.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import UIKit
import IMDbApiModule

class HomeViewRouter: HomeViewRouting {
    
    var navigationController: UINavigationController?
    
    func routeToMovieDetails(for movie: MostPopularDataDetail) {
        let vc = IMDbAppDependencies.shared.makeMovieDetailsViewController(for: movie.id )
        navigationController?.pushViewController(vc, animated: true)
    }
}
