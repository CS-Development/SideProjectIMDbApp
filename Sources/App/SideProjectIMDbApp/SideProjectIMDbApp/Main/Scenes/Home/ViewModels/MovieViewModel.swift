//
//  MovieViewModel.swift
//  SideProjectIMDbApp
//
//  Created by Khalil Mb on 18/08/2021.
//

import Foundation
import IMDbApiModule

class MovieViewModel {
    
    ///vars
    private var manager: IMDbManagerProtocol
    private var mostPopularMovies = [MostPopularDataDetail]()
    
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
                    break
                case .failure(let error):
                    print("error")
                }
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        return mostPopularMovies.count
    }
}
