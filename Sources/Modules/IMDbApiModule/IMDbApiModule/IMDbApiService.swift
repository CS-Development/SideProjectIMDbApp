//
//  IMDbApiService.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 25.07.21.
//

import Foundation
import NetworkingService

public protocol IMDbApiServiceProtocol {
    typealias ServiceError = NetworkingServiceError
    init(baseURL: URL, client: HTTPClient, apiKey: String)
    
    // MARK: - Browse
    func getMostPopularMovies(completion: @escaping (Swift.Result<MostPopularData, ServiceError>)->Void)
    func getMostPopularTvs(completion: @escaping (Swift.Result<MostPopularData, ServiceError>)->Void)
    func getBoxOffice(completion: @escaping (Swift.Result<BoxOfficeWeekendData, ServiceError>)->Void)
    func getBoxOfficeAllTime(completion: @escaping (Swift.Result<BoxOfficeAllTimeData, ServiceError>)->Void)
    func getNewMovies(completion: @escaping (Swift.Result<NewMovieData, ServiceError>)-> Void)
    
    // MARK: - Search
    func searchMovie(title: String, completion: @escaping (Swift.Result<SearchData, ServiceError>)-> Void)
    
    // MARK: - Title
    func getTitle(for id: String, completion: @escaping (Swift.Result<TitleData, ServiceError>)-> Void )
    
    // MARK: - Trailer
    func getTrailer(for id: String, completion: @escaping (Swift.Result<TrailerData, ServiceError>)-> Void )
}

public class IMDbApiService: IMDbApiServiceProtocol {
    
    private var baseURL: URL
    private var client: HTTPClient
    private var apiKey: String
    
    public typealias ServiceError = NetworkingServiceError
    
    required public init(baseURL: URL, client: HTTPClient, apiKey: String) {
        self.baseURL = baseURL
        self.client = client
        self.apiKey = apiKey
    }
    

    //https://imdb-api.com/en/API/MostPopularMovies/k_12345678
    public func getMostPopularMovies(completion: @escaping (Swift.Result<MostPopularData, ServiceError>)->Void) {
        let url = baseURL.appendingPathComponent("API/MostPopularMovies").appendingPathComponent(apiKey)
        client.makeRequest(toURL: url, withHttpMethod: .get) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    //https://imdb-api.com/en/API/MostPopularTVs/k_12345678
    public func getMostPopularTvs(completion: @escaping (Swift.Result<MostPopularData, ServiceError>)->Void) {
        let url = baseURL.appendingPathComponent("API/MostPopularTVs").appendingPathComponent(apiKey)
        client.makeRequest(toURL: url, withHttpMethod: .get) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    //https://imdb-api.com/en/API/BoxOffice/k_12345678
    public func getBoxOffice(completion: @escaping (Swift.Result<BoxOfficeWeekendData, ServiceError>)->Void) {
        let url = baseURL.appendingPathComponent("API/BoxOffice").appendingPathComponent(apiKey)
        client.makeRequest(toURL: url, withHttpMethod: .get) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    // https://imdb-api.com/en/API/BoxOfficeAllTime/k_12345678
    public func getBoxOfficeAllTime(completion: @escaping (Swift.Result<BoxOfficeAllTimeData, ServiceError>)->Void) {
        let url = baseURL.appendingPathComponent("API/BoxOfficeAllTime").appendingPathComponent(apiKey)
        client.makeRequest(toURL: url, withHttpMethod: .get) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    //https://imdb-api.com/en/API/ComingSoon/k_12345678
    public func getNewMovies(completion: @escaping (Result<NewMovieData, ServiceError>) -> Void) {
        let url = baseURL.appendingPathComponent("API/ComingSoon").appendingPathComponent(apiKey)
        client.makeRequest(toURL: url, withHttpMethod: .get) { [weak self] result in
            guard self != nil else {return}
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
  
    //https://imdb-api.com/en/API/SearchMovie/k_12345678/Inception 2010
    public func searchMovie(title: String, completion: @escaping (Result<SearchData, ServiceError>) -> Void) {
        let url = baseURL.appendingPathComponent("API/SearchMovie").appendingPathComponent(apiKey).appendingPathComponent(title)
        client.makeRequest(toURL: url, withHttpMethod: .get) { [weak self] result in
            guard self != nil else {return}
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    
    public func getTitle(for id: String, completion: @escaping (Result<TitleData, ServiceError>) -> Void) {
        let url = baseURL.appendingPathComponent("API/Title").appendingPathComponent(apiKey).appendingPathComponent(id)
        client.makeRequest(toURL: url, withHttpMethod: .get) { [weak self] result in
            guard self != nil else {return}
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    public func getTrailer(for id: String, completion: @escaping (Result<TrailerData, ServiceError>) -> Void) {
        let url = baseURL.appendingPathComponent("API/Trailer").appendingPathComponent(apiKey).appendingPathComponent(id)
        client.makeRequest(toURL: url, withHttpMethod: .get) { [weak self] result in
            guard self != nil else {return}
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    
}
