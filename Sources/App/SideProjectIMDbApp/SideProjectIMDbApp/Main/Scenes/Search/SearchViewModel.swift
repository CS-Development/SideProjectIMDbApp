//
//  SearchViewModel.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 30.08.21.
//

import Foundation
import IMDbApiModule

class SearchViewModel {
    
    ///vars
    private var manager: IMDbManagerProtocol
    
    // MARK: - Init
    init(manager: IMDbManagerProtocol) {
        self.manager = manager
    }
    
    public func searchMovieBy(title: String) {
        manager.searchMovie(title: title) { answer in
            print(answer)
        }
    }
}
