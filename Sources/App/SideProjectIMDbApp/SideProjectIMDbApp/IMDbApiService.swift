//
//  IMDbApiService.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 25.07.21.
//

import Foundation
import NetworkingService



class IMDbManager {
    var token: String!
    var service: IMDbApiService!
    
    func refreshToken() {
        service.getApiToken(completion: { tokenResult in
            switch tokenResult {
            case let .failure(error):
                print(error)
            case let .success(tokenDTO):
                self.token = tokenDTO.accessToken
            }
        })
    }
    
    func getToken() -> String {
        return token
    }
}

class IMDbApiService {
    
    private var baseURL: URL
    private var client: HTTPClient
    private var apiKey: String?
    
    typealias ServiceError = NetworkingServiceError
    typealias TokenResult = Swift.Result<AccessTokenDTO, ServiceError>
    
    public init(baseURL: URL, client: HTTPClient, apiKey: String? = nil) {
        self.baseURL = baseURL
        self.client = client
        self.apiKey = apiKey
    }
    
    public func getApiToken(completion: @escaping (TokenResult) -> Void) {
        //TODO erase parameters
        let clientID = "d670a599fdc64b5f920f82b4450a9a4e"
        let clientSecret = "58dd176d8bba4a7b935084c06e7d3ea1"
        let base64Encoded = "\(clientID):\(clientSecret)".toBase64()
        client.requestHttpHeaders.add(value: "Basic \(base64Encoded)", forKey: "Authorization")
        client.requestHttpHeaders.add(value: "application/x-www-form-urlencoded", forKey: "Content-Type")
        client.httpBodyParameters.add(value: "client_credentials", forKey: "grant_type")
        client.makeRequest(toURL: baseURL.appendingPathComponent("token"), withHttpMethod: .post) { [weak self] result in
                guard self != nil else { return }
                
                completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
}

public struct AccessTokenDTO: DTO {
    public var accessToken: String
    public var tokenType: String
    public var expiresIn: Int
    
    public init(accessToken: String, tokenType: String, expiresIn: Int) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
    }
    
    public var description: String {
        return """
        ------------
        accessToken = \(accessToken)
        tokenType = \(tokenType)
        expiresIn = \(expiresIn)
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
