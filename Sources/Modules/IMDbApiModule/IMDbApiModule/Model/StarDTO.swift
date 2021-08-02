//
//  StarDTO.swift
//  IMDbApiModule
//
//  Created by Khalil Mb on 02/08/2021.
//

import Foundation
import NetworkingService

public struct StarDTO: DTO {
    var id:                String
    var name:              String
    public var description: String {
    
    return """
    ------------
    key = \(id)
    value = \(name)
    ------------
    """
    }
}
