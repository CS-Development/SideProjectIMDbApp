//
//  NetworkingServiceError.swift
//  NetworkingService
//
//  Created by Christian Slanzi on 03.06.21.
//

import Foundation

public enum NetworkingServiceError: Swift.Error {
    case connectivity
    case invalidData
    case badRequest
    case notAuthorized
}
