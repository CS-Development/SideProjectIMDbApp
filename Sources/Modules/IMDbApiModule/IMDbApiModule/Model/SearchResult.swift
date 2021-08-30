//
//  SearchResult.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 06/08/2021.
//

import Foundation
import NetworkingService

public struct SearchResult: DTO{
    public var id:                 String
    public var resultType:         String
    public var image:              String
    public var title:              String
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
