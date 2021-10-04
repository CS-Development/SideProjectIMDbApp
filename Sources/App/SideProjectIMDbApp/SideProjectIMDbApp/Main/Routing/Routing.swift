//
//  Routing.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import Foundation
import UIKit
import IMDbApiModule

protocol Routing {
    var navigationController: UINavigationController? { set get }
}

// Routes

// routeToMovieDetails

protocol HomeViewRouting: Routing {
    func routeToMovieDetails(for movie: MostPopularDataDetail)
}

protocol SearchViewRouting: Routing {
    func routeToMovieDetails(for movie: SearchResult)
}

protocol ProfileViewRouting: Routing {
    // route to somewhere
}

protocol VideoViewRouting: Routing {
    // route to somewhere
    func routeToVideoDetails(for movie: MostPopularDataDetail)
}
