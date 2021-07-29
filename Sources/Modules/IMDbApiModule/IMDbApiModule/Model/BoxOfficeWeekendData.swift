//
//  BoxOfficeWeekendData.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 26/07/2021.
//

import Foundation
import NetworkingService
public struct BoxOfficeWeekendData: DTO {
    
    public var items: [BoxOfficeWeekendDataDetail]
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
