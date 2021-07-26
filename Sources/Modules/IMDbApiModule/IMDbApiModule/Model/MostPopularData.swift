//
//  MostPopularData.swift
//  IMDbApiModule
//
//  Created by Christian Slanzi on 26.07.21.
//

import Foundation
import NetworkingService

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
