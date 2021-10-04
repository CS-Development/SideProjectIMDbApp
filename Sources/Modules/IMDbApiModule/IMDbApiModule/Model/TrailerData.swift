//
//  TrailerData.swift
//  IMDbApiModule
//
//  Created by Christian Slanzi on 04.10.21.
//

import Foundation
import NetworkingService

public struct TrailerData: DTO
{
    public var imDbId:                   String
    public var title:                    String
    public var fullTitle:                String
    public var type:                     String
    public var year:                     String
    
    public var videoId:                  String
    public var videoTitle:               String
    public var videoDescription:         String
    public var thumbnailUrl:             String
    public var uploadDate:               String
    public var link:                     String
    public var linkEmbed:                String
    
    public var errorMessage:             String
    
    public var description: String {
        return """
        ------------
        id = \(imDbId)
        title = \(title)
        fullTitle = \(fullTitle)
        year = \(year)
        videoId = \(videoId)
        ------------
        """
    }
}
