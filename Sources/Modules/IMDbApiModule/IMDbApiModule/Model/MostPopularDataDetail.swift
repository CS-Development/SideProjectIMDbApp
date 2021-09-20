//
//  MostPopularDataDetail.swift
//  IMDbApiModule
//
//  Created by Christian Slanzi on 26.07.21.
//

import Foundation
import NetworkingService


/*
// Composition
func mapMostPopularDataDetailtoMovie(dto: MostPopularDataDetail) -> Movie {
    return Movie(identifier: dto.id, title: dto.fullTitle, description: <#T##String#>)
}



/// Presentation Layer

class MovieView {
    var model: MovieViewModel
    
    func render() {
        uilabel.text = model.getMovieTitle()
    }
}


struct MovieViewModel {
    var movie: Movie
    
    func getMovieTitle() -> String {
        return String(movie.title)
    }
}




/// Business Layer

public struct Movie {
    public var identifier: String
    public var title: String
    public var description: String
    
    
}

public class MovieManager {
    var movies: [Movie]
    var favourites: [Movie]
    //methods to operate on movie objects
    //
    
    func saveMovieToFavourites(id: String) {
        // search movie id in movies array
        // if found, store it in the favourites array
    }
}

*/

/// Data Layer

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







