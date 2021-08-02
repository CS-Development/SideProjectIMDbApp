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
    public var fullTitle:                                 String
    public var year:                                      String
    public var releaseState:                              String
    public var image:                                     String
    public var runtimeMins:                               String
    public var runtimeStr:                                String
    public var plot:                                      String
    public var contentRating:                             String
    public var imDbRating:                                String
    public var imDbRatingCount:                           String
    public var metacriticRating:                          String
    public var genres:                                    String
    public var genreList:                                 [GenreDTO]
    public var directors:                                 String
    public var directorList:                              [DirectorDTO]
    public var stars:                                     String
    public var starList:                                  [StarDTO]
    public var description: String {
        return """
        ------------
        id = \(id)
        title = \(title)
        fulltitle = \(fullTitle)
        year = \(year)
        releaseState = \(releaseState)
        runtimeMins = \(runtimeMins)
        runtimeStr = \(runtimeStr)
        plot = \(plot)
        contentRating = \(contentRating)
        iMDbRatingCount = \(imDbRatingCount)
        metacriticRating = \(metacriticRating)
        genres = \(genres)
        GenreList = \(genreList)
        directors = \(directors)
        directorList = \(directorList)
        stars = \(stars)
        starList = \(starList)
        ------------
        """
    }
    
}

