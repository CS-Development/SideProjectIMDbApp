//
//  TitleData.swift
//  IMDbApiModule
//
//  Created by Christian Slanzi on 20.09.21.
//

import Foundation
import NetworkingService

public struct TitleData: DTO
{
    public var id:                       String
    public var title:                    String
    public var originalTitle:            String
    public var fullTitle:                String
    public var year:                     String
    public var image:                    String
    public var imDbRating:               String
    
    public var description: String {
        return """
        ------------
        id = \(id)
        originalTitle = \(originalTitle)
        title = \(title)
        fullTitle = \(fullTitle)
        year = \(year)
        image = \(image)
        imDbRating = \(imDbRating)
        ------------
        """
    }
}
