//
//  VideoDetailsViewModel.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 04.10.21.
//

import Foundation
import IMDbApiModule

//MVVM

//Model -> ViewModel -> View

struct VideoDetailsViewModel { // viewModel is a converter from Model's Infos to View's infos
    
    private let movie: MostPopularDataDetail
    private let trailer: TrailerData
    
    init(movie: MostPopularDataDetail, trailer: TrailerData) {
        self.movie = movie
        self.trailer = trailer
    }
    
    // presentation properties
    private var videoPreviewUrl: String {
        trailer.thumbnailUrl
    }

    var videoStatus: String = "NOW PLAYING"
    
    func getImageUrl() -> URL? {
        let url = URL(string: videoPreviewUrl)
        return url
    }
    
    func getTrailerUrl() -> URL? {
        let url = URL(string: trailer.link)
        return url
    }
}
