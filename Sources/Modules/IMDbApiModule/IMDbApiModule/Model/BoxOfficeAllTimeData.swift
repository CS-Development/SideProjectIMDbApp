//
//  MovieShort.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 28/07/2021.
//

import Foundation
import NetworkingService

public struct BoxOfficeAllTimeData: DTO {
    public var items: [BoxOfficeAllTimeDataDetail]
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
