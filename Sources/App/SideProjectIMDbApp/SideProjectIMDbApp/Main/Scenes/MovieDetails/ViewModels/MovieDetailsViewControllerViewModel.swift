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
}
