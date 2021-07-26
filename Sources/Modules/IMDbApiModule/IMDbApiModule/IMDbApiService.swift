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
    func getMostPopularMovies(completion: @escaping (Swift.Result<MostPopularData, ServiceError>)->Void)
    func getMostPopularTvs(completion: @escaping (Swift.Result<MostPopularData, ServiceError>)->Void)
    func getBoxOffice(completion: @escaping (Swift.Result<BoxOfficeWeekendData, ServiceError>)->Void)
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
}
