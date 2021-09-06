//
//  MovieDetailsViewControllerViewModel.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import Foundation
import IMDbApiModule

class MovieDetailsViewControllerViewModel {
    
    let movie: MostPopularDataDetail
    init(movie: MostPopularDataDetail) {
        self.movie = movie
    }
    
    func getTitle() -> String {
        return movie.title
    }
    
    func getDescription() ->  String {
        return movie.fullTitle
    }
    
    func getCrew() -> String {
        return movie.crew
    }
    
    func getImageUrl() -> URL? {
        return URL(string: movie.image)
    }
}
