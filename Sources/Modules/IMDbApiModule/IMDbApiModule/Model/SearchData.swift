//
//  SearchData.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 06/08/2021.
//

import Foundation
import NetworkingService

public struct SearchData: DTO {
    var searchType:              String
    var expression:              String
    public var results:                [SearchResult]
    var errorMessage:            String
    public var description: String {
        return """
        ------------
        searchType = \(searchType)
        expression = \(expression)
        results = \(results)
        errorMessage = \(errorMessage)
        ------------
        """
    
    }
}

public enum SearchType
{
    case title
    case movie
    case series
    case name
    case episode
    case company
    case keyword
    case all

}
