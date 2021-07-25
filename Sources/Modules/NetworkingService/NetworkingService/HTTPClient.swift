//
//  HTTPClient.swift
//  NetworkingService
//
//  Created by Christian Slanzi on 23.04.21.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    
    var requestHttpHeaders: HTTPClientEntity { get set }
    var urlQueryParameters: HTTPClientEntity { get set }
    var httpBodyParameters: HTTPClientEntity { get set }
    
    
    @discardableResult
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HTTPMethod,
                     completion: @escaping (_ result: HTTPClientResult) -> Void)  -> HTTPClientTask
    
    @discardableResult
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HTTPMethod,
                     cachePolicy: NSURLRequest.CachePolicy,
                     timeoutInterval: TimeInterval,
                     completion: @escaping (_ result: HTTPClientResult) -> Void)  -> HTTPClientTask
    
    func getData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void)
}

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

public struct HTTPClientResult {
    public var data: Data?
    public var response: HTTPClientResponse?
    public var error: Error?

    public init(withData data: Data?, response: HTTPClientResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    public init(withError error: Error) {
        self.error = error
    }
}

public struct HTTPClientEntity {

    private var values: [String: String] = [:]
    
    public init() {}
    
    public mutating func add(value: String, forKey key: String) {
        values[key] = value
    }
    
    public func value(forKey key: String) -> String? {
        return values[key]
    }
    
    public func allValues() -> [String: String] {
        return values
    }
    
    public func totalItems() -> Int {
        return values.count
    }
}

public struct HTTPClientResponse {
    var response: URLResponse?
    public var statusCode: Int = 0
    public var headers = HTTPClientEntity()
    
    public init(fromURLResponse response: URLResponse?) {
        guard let response = response else { return }
        self.response = response
        statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    
        if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
            for (key, value) in headerFields {
                headers.add(value: "\(value)", forKey: "\(key)")
            }
        }
    }
}
