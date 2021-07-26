//
//  IMDbApiService.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 25.07.21.
//

import Foundation
import NetworkingService

class IMDbManager {
    var service: IMDbApiService
    
    init(service: IMDbApiService) {
        self.service = service
    }
    
    func getMostPopularMovies(completion: @escaping (MostPopularData)->Void ) {
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
}

class IMDbApiService {
    
    private var baseURL: URL
    private var client: HTTPClient
    private var apiKey: String
    
    typealias ServiceError = NetworkingServiceError
    
    public init(baseURL: URL, client: HTTPClient, apiKey: String) {
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
}

public struct MostPopularData: DTO
{
    public var items: [MostPopularDataDetail]

    public var errorMessage: String
    
    public var description: String {
        return """
        ------------
        items = \(items)
        errorMessage = \(errorMessage)
        ------------
        """
    }
}

public struct MostPopularDataDetail: DTO
{
    public var id:                       String
    public var rank:                     String
    public var rankUpDown:               String
    public var title:                    String
    public var fullTitle:                String
    public var year:                     String
    public var image:                    String
    public var crew:                     String
    public var imDbRating:               String
    public var imDbRatingCount:          String
    
    public var description: String {
        return """
        ------------
        id = \(id)
        rank = \(rank)
        rankUpDown = \(rankUpDown)
        title = \(title)
        fullTitle = \(fullTitle)
        year = \(year)
        image = \(image)
        crew = \(crew)
        imDbRating = \(imDbRating)
        imDbRatingCount = \(imDbRatingCount)
        ------------
        """
    }
}





extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}
