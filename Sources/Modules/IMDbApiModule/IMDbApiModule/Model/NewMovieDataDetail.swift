//
//  NewMovieDataDetail.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 31/07/2021.
//

import Foundation
import NetworkingService
public struct NewMovieDataDetail: DTO {
    public var id:                                        String
    public var title:                                     String
    public var fulltitle:                                 String
    public var year:                                      String
    public var releaseState:                              String
    public var image:                                     String
    public var runtimeMins:                               String
    public var runtimeStr:                                String
    public var plot:                                      String
    public var contentRating:                             String
    public var iMDbRatingCount:                           String
    public var metacriticRating:                          String
    public var genres:                                    String
    public var GenreList:                                 [String]
    public var directors:                                 String
    public var DirectorList:                              [String]
    public var stars:                                     String 
    public var StarList:                                  [String]
    public var description: String {
        return """
        ------------
        id = \(id)
        title = \(title)
        fulltitle = \(fulltitle)
        year = \(year)
        releaseState = \(releaseState)
        runtimeMins = \(runtimeMins)
        runtimeStr = \(runtimeStr)
        plot = \(plot)
        contentRating = \(contentRating)
        iMDbRatingCount = \(iMDbRatingCount)
        metacriticRating = \(metacriticRating)
        genres = \(genres)
        GenreList = \(GenreList)
        directors = \(directors)
        DirectorList = \(DirectorList)
        stars = \(stars)
        DirectorList = \(StarList)
        stars = \(StarList)
        ------------
        """
    }
    
}

