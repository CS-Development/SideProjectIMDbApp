//
//  BoxOfficeWeekendDataDetail.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 26/07/2021.
//

import Foundation
import NetworkingService
public struct BoxOfficeWeekendDataDetail: DTO {
    
    
    public var id:                       String
    public var rank:                     String
    public var title:                    String
    public var image:                    String
    public var weekend:                  String
    public var gross:                    String
    public var weeks:                    String
    
    public var description: String {
        return """
        ------------
        id = \(id)
        rank = \(rank)
        title = \(title)
        image = \(image)
        gross = \(gross)
        weeks = \(weeks)
        weekend = \(weekend)
        ------------
        """
    }
}
