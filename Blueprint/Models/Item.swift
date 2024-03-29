//
//  Item.swift
//  Blueprint
//
//  Created by Jay Lees on 07/03/2019.
//  Copyright © 2019 Manhattan. All rights reserved.
//

import Foundation

public struct Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "item_id"
        case name = "name"
        case type = "type"
    }
    
    
    public enum ItemType: Int, Decodable {
        case primaryResource = 1
        case blueprintPlaceable = 2
        case machineryUnplaceable = 3
        case blueprintUnplaceable = 4
        case intangible = 5
    }

    
    let id: Int
    let name: String
    let type: ItemType
}
