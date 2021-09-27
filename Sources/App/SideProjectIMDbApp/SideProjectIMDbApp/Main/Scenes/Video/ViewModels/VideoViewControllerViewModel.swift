//
//  VideoViewControllerViewModel.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 27.09.21.
//

import Foundation
import IMDbApiModule

class VideoViewControllerViewModel {
    
    enum VideoSectionTypes: Int {
        case popularTrailers = 0
        case recentTrailers = 1
    }
    
    ///vars
    private var manager: IMDbManagerProtocol
    
    private var mostPopularMovies: [MostPopularDataDetail] = []
    
    var reloadCollectionView: () -> Void = { }
    
    // MARK: - Init
    init(manager: IMDbManagerProtocol) {
        self.manager = manager
    }
    
    public func getData() {
        manager.getMostPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.mostPopularMovies = response.items
                    self?.reloadCollectionView()
                    break
                case .failure(let error):
                    print("Failed to fetch most popular movies: \(error)")
                }
            }
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        guard let videoSection = VideoSectionTypes(rawValue: section) else { return 0 }
        
        switch videoSection {
        case .popularTrailers:
            return mostPopularMovies.count
        case .recentTrailers:
            return 0
        }
    }
    
    func getMovieForIndexPath(indexPath: IndexPath) -> MostPopularDataDetail? {
        guard let videoSection = VideoSectionTypes(rawValue: indexPath.section) else { return nil }
        
        switch videoSection {
        case .popularTrailers:
            return mostPopularMovies[indexPath.row]
        case .recentTrailers:
            return mostPopularMovies[indexPath.row]
        }
    }
    
}
