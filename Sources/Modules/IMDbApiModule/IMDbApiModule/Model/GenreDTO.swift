//
//  GenreDTO.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 02/08/2021.
//

import Foundation
import NetworkingService
public struct GenreDTO: DTO {
    var key:                String
    var value:              String
    public var description: String {
    
    return """
    ------------
    key = \(key)
    value = \(value)
    ------------
    """
    }
}
