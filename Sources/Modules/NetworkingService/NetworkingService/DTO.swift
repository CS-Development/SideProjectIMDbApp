//
//  DTO.swift
//  NetworkingService
//
//  Created by Christian Slanzi on 03.06.21.
//

import Foundation

public protocol DTO: Codable, CustomStringConvertible, Hashable {
    
}

extension Array: DTO where Element: DTO
{
    
}

