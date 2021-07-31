//
//  NewMovieData.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 31/07/2021.
//

import Foundation
import NetworkingService
public struct NewMovieData: DTO {
    public var items: [NewMovieDataDetail]
    public  var errorMessage: String
    public var description: String {
        return """
        ------------
        items = \(items)
        errorMessage = \(errorMessage)
        ------------
        """
    
    }
    
    
    
}
