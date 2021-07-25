//
//  APIManager.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 24.07.21.
//

import Foundation
import NetworkingService

//class BaseAPIManager {
//    public func login() {}
//    public func getAlbums(completion: @escaping (AlbumModel?)->Void) {}
//}

public protocol BaseAPIManager {
    func login()
    func getAlbums(completion: @escaping (AlbumModel?)->Void)
}

class FakeAPIManager: BaseAPIManager {
    static let shared = FakeAPIManager()
    public func login() {
        // fake implementation
        
        let login = LoginModel(token: "eheheehjejjeje")
    }
    
    public func getAlbums(completion: @escaping (AlbumModel?)->Void) {
        // fake implementation
        
        let album = AlbumModel(href: "https://fgjfkfk.com")
        completion(album)
    }
}

class APIManager: BaseAPIManager {
    
    static let shared = APIManager()
    
    public func login() {
        var request = createRequest("/login")
        setupRequest(&request)
        performRequest(request, parsing: { data in
            if let login = self.parseJSONloginModel(data: data) {
                print("login token = \(login.token)")
            }
        })
    }
    
    public func getAlbums(completion: @escaping (AlbumModel?)->Void) {
        var request = createRequest("/getAlbums")
        setupRequest(&request)
        performRequest(request, parsing: { data in
            if let album = self.parseJSONAlbumModel(data: data) {
                print("album href = \(album.href)")
                return completion(album)
            }
        })
    }
}

extension APIManager {
    
    func createRequest(_ path: String) -> URLRequest {
        // Create URL
        let baseUrl = "https://api.spotify.com/v1"
        let url = URL(string: baseUrl + path)
        guard let requestUrl = url else { fatalError() }
        
        // Create URL Request
        let request = URLRequest(url: requestUrl)
        return request
    }
    
    func setupRequest(_ request: inout URLRequest) {
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Set HTTP Request Header
        request.setValue("Bearer BQD8NtKU2MjsTOqup1RyScIvlmZoP_x53ZGabiRSHBGqvPIkRxE7dIU8IbUhsmeZPUkec8boXLr_gst5L-o", forHTTPHeaderField: "Authorization")
    }
    
    func performRequest(_ request: URLRequest, parsing: @escaping (Data)->Void ) {
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                
                // parsing : self.parseJSONloginModel(data: data)
                parsing(data)
            }
        }
        task.resume()
    }
    
    func parseJSONAlbumModel(data: Data) -> AlbumModel? {
        
        var returnValue: AlbumModel?
        do {
            returnValue = try JSONDecoder().decode(AlbumModel.self, from: data)
        } catch {
            print("Error took place\(error.localizedDescription).")
        }
        
        return returnValue
    }
    
    func parseJSONloginModel(data: Data) -> LoginModel? {
        
        var returnValue: LoginModel?
        do {
            returnValue = try JSONDecoder().decode(LoginModel.self, from: data)
        } catch {
            print("Error took place\(error.localizedDescription).")
        }
        
        return returnValue
    }
}

public struct AlbumModel: DTO {
    
    public var href: String

    public var description: String {
        return """
        ------------
        href = \(href)
        ------------
        """
    }
}

public struct LoginModel: Decodable {
    
    public var token: String

    public var description: String {
        return """
        ------------
        token = \(token)
        ------------
        """
    }
}
