//
//  BoxOfficeAllTimeDataDetail.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 28/07/2021.
//

import Foundation
import NetworkingService

public struct BoxOfficeAllTimeDataDetail: DTO {
    public var id:                                        String
    public var rank:                                      String
    public var title:                                     String
    public var worldwideLifetimeGross:                    String
    public var domesticLifetimeGross:                     String
    public var domestic:                                  String
    public var foreignLifetimeGross:                      String
    public var foreign:                                   String
    public var year:                                      String
    
    public var description: String {
        return """
        ------------
        id = \(id)
        rank = \(rank)
        title = \(title)
            worldwideLifetimeGross = \(worldwideLifetimeGross)
            domesticLifetimeGross = \(domesticLifetimeGross)
            domestic = \(domestic)
            foreignLifetimeGross = \(foreignLifetimeGross)
            foreign = \(foreign)
            year = \(year)
        ------------
        """
    }
}

