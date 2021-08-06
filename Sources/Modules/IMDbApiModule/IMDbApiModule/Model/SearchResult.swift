//
//  SearchResult.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 06/08/2021.
//

import Foundation
import NetworkingService

public struct SearchResult: DTO{
    var id:                 String
    var resultType:         String
    var image:              String
    var title:              String
    public var description: String {
    
    return """
    ------------
    id = \(id)
    resultType = \(resultType)
    image = \(image)
    title = \(title)
    ------------
    """
    }
}
