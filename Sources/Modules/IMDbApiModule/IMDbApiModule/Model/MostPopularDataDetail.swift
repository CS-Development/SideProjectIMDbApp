//
//  MostPopularDataDetail.swift
//  IMDbApiModule
//
//  Created by Christian Slanzi on 26.07.21.
//

import Foundation
import NetworkingService

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
