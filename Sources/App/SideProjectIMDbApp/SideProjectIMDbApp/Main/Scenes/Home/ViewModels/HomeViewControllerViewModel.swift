//
//  MovieViewModel.swift
//  SideProjectIMDbApp
//
//  Created by Khalil Mb on 18/08/2021.
//

import Foundation
import IMDbApiModule

class HomeViewControllerViewModel {
    
    ///vars
    private var manager: IMDbManagerProtocol
    
    private var mostPopularMovies: [MostPopularDataDetail] = []
    private var mostPopularTvs: [MostPopularDataDetail] = []
    
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
                    self?.mostPopularMovies = response.items.dropLast(90)
                    self?.reloadCollectionView()
                    break
                case .failure(let error):
                    print("error")
                }
            }
        }
        
        manager.getMostPopularTvs { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.mostPopularTvs = response.items.dropLast(90)
                    self?.reloadCollectionView()
                    break
                case .failure(let error):
                    print("error")
                }
            }
        }
    }
    
    func numberOfItemsInSection(section: HomeSectionTypes) -> Int {
        switch section {
        case .mostPopularMovies:
            return mostPopularMovies.count
        case .mostPopularTvs:
            return mostPopularTvs.count
        }
    }
    
    func getMovieForIndexPath(indexPath: IndexPath) -> MostPopularDataDetail? {
        guard let homeSection = HomeSectionTypes(rawValue: indexPath.section) else { return nil }
        
        switch homeSection {
        case .mostPopularMovies:
            return mostPopularMovies[indexPath.row]
        case .mostPopularTvs:
            return mostPopularTvs[indexPath.row]
        }
    }
}

enum HomeSectionTypes: Int {
    case mostPopularMovies = 0
    case mostPopularTvs = 1
}
