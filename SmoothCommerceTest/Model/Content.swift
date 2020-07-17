//
//  User.swift
//  SmoothCommerceTest
//
//  Created by Rafael Cunha de Oliveira on 2020-07-17.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

enum ContentType: String {
    case name = "text"
    case url = "url"
    case image = "image"
    case video = "video"
}

struct Cell: Decodable { // Decodable Objects to help deserialize service response
    var data: [Item]
}

struct Item: Decodable {
    var type: String?
    var data: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "item_type"
        case data
    }
}
