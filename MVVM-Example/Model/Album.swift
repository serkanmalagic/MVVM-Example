//
//  Album.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 6.11.2021.
//

import Foundation

struct Album: Codable {
    
    let userID, id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
