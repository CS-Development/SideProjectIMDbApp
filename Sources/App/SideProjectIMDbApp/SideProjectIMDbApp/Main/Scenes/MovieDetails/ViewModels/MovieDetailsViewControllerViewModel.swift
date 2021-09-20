//
//  MovieDetailsViewControllerViewModel.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import Foundation
import IMDbApiModule

class MovieDetailsViewControllerViewModel {
    
//    let movie: MostPopularDataDetail
//    init(movie: MostPopularDataDetail) {
//        self.movie = movie
//        movie.id
//    }
    
    weak var delegate: MovieDetailsDelegate?
    
    var movie: TitleData? = nil
    
    let movieId: String
    let manager: IMDbManagerProtocol
    
    init(id: String, manager: IMDbManagerProtocol) {
        self.manager = manager
        self.movieId = id
    }
    
    func loadMovie() {
        manager.getTitle(for: movieId) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let titleData):
                strongSelf.movie = titleData
                strongSelf.delegate?.reloadData()
                
            case .failure(let error):
                print("failed to fetch TitleDatga object: \(error)")
            }
        }
    }
    
    func getTitle() -> String {
        guard let movie = movie else { return "-" }
        return movie.title
    }
    
    func getDescription() ->  String {
        guard let movie = movie else { return "-" }
        return movie.fullTitle
    }
    
//    func getCrew() -> String {
//        return movie.crew
//    }
    
    func getImageUrl() -> URL? {
        guard let movie = movie else { return nil }
        
        let url = URL(string: movie.image)
        
        return url?.convertToImdbImageOriginalUrl()
    }
}
