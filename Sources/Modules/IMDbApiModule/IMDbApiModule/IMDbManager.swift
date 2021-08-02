//
//  IMDbManager.swift
//  IMDbApiModule
//
//  Created by Christian Slanzi on 26.07.21.
//

import Foundation

public protocol IMDbManagerProtocol {
    init(service: IMDbApiServiceProtocol)
    func getMostPopularMovies(completion: @escaping (MostPopularData)->Void )
    func getMostPopularTvs(completion: @escaping (MostPopularData)->Void )
    func getBoxOffice(completion: @escaping (BoxOfficeWeekendData)->Void)
    func getBoxOfficeAllTime(completion: @escaping (BoxOfficeAllTimeData)->Void)
    func getNewMovies(completion: @escaping (NewMovieData)->Void)
}

public class IMDbManager: IMDbManagerProtocol {
    
    
    
    public func getBoxOffice(completion: @escaping (BoxOfficeWeekendData) -> Void) {
        service.getBoxOffice { result in
            switch result {
            case let .failure(error):
                print(error)
                break
            case let .success(answer):
                completion(answer)
                break
            }
        }
    }
    
    var service: IMDbApiServiceProtocol
    
    required public init(service: IMDbApiServiceProtocol) {
        self.service = service
    }
    
    public func getMostPopularMovies(completion: @escaping (MostPopularData)->Void ) {
        service.getMostPopularMovies { result in
            switch result {
            case let .failure(error):
                print(error)
                break
            case let .success(answer):
                completion(answer)
                break
            }
        }
    }
    
    public func getMostPopularTvs(completion: @escaping (MostPopularData)->Void ) {
        service.getMostPopularTvs { result in
            switch result {
            case let .failure(error):
                print(error)
                break
            case let .success(answer):
                completion(answer)
                break
            }
        }
    }
    
    public func getBoxOfficeAllTime(completion: @escaping (BoxOfficeAllTimeData)->Void ) {
        service.getBoxOfficeAllTime { (result) in
            switch result {
            case let .failure(error):
                print(error)
                break
            case let .success(answer):
                completion(answer)
                break
            }
        }
        
    }
    public func getNewMovies(completion: @escaping (NewMovieData) -> Void) {
        service.getNewMovies { (result) in
            switch result {
            case let .failure(error):
                print(error)
                break
            case let .success(answer):
                completion(answer)
                break
            }
        }
    }
    
    
}
