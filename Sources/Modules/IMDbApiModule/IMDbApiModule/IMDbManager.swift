//
//  IMDbManager.swift
//  IMDbApiModule
//
//  Created by Christian Slanzi on 26.07.21.
//

import Foundation
import NetworkingService

public protocol IMDbManagerProtocol {
    init(service: IMDbApiServiceProtocol)
    func getMostPopularMovies(completion: @escaping (Result<MostPopularData, NetworkingServiceError>)->Void )
    func getMostPopularTvs(completion: @escaping (Result<MostPopularData, NetworkingServiceError>)->Void )
    
    func getBoxOffice(completion: @escaping (Result<BoxOfficeWeekendData, NetworkingServiceError>)->Void)
    func getBoxOfficeAllTime(completion: @escaping (BoxOfficeAllTimeData)->Void)
    func getNewMovies(completion: @escaping (NewMovieData)->Void)
    
    func searchMovie(title: String ,completion: @escaping (Result<SearchData, NetworkingServiceError>)-> Void)
}

public class IMDbManager: IMDbManagerProtocol {
    
    public func getBoxOffice(completion: @escaping (Result<BoxOfficeWeekendData, NetworkingServiceError>) -> Void) {
        service.getBoxOffice { result in
            switch result {
            case let .failure(error):
                print(error)
                break
            case .success(_):
                completion(result)
                break
            }
        }
    }
    
    var service: IMDbApiServiceProtocol
    
    required public init(service: IMDbApiServiceProtocol) {
        self.service = service
    }
    
    public func getMostPopularMovies(completion: @escaping (Result<MostPopularData, NetworkingServiceError>) -> Void) {
        service.getMostPopularMovies { result in
            switch result {
            case .failure(let error):
                print(error)
                break
            case .success(_):
                completion(result)
                break
            }
        }
    }
    
    public func getMostPopularTvs(completion: @escaping (Result<MostPopularData, NetworkingServiceError>)->Void ) {
        service.getMostPopularTvs { result in
            switch result {
            case let .failure(error):
                print(error)
                break
            case .success(_):
                completion(result)
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
    
    public func searchMovie(title: String, completion: @escaping (Result<SearchData, NetworkingServiceError>) -> Void) {
        service.searchMovie(title: title) { (result) in
            switch result {
            case let .failure(error):
                print(error)
                break
            case .success(_):
                completion(result)
                break
            }
        }
    }
    
    
    
    
}
