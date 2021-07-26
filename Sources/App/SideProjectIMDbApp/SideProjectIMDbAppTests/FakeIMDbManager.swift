//
//  FakeIMDbManager.swift
//  SideProjectIMDbAppTests
//
//  Created by Christian Slanzi on 26.07.21.
//

import Foundation
@testable import SideProjectIMDbApp
import IMDbApiModule

class FakeIMDbManager: IMDbManagerProtocol {
    var service: IMDbApiService
    
    required public init(service: IMDbApiService) {
        self.service = service
    }
    
    public func getMostPopularMovies(completion: @escaping (MostPopularData)->Void ) {
        //faking
        //create some fake data
        //completion(fakeData)
    }
    
    public func getMostPopularTvs(completion: @escaping (MostPopularData)->Void ) {
        //faking
        //create some fake data
        //completion(fakeData)
    }
}
