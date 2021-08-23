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
    var reloadCollectionView: () -> Void = { }
    // MARK: - Init
    init(manager: IMDbManagerProtocol) {
        self.manager = manager
    }
    
    func getMostPopularMovies(){
        manager.getMostPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.mostPopularMovies = response.items
                    self?.reloadCollectionView()
                    break
                case .failure(let error):
                    print("error")
                }
            }
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return mostPopularMovies.count
    }
   
    
    func getMovieForIndexPath(indexPath: IndexPath) -> MostPopularDataDetail {
        return mostPopularMovies[indexPath.row]
    }
}
