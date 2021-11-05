//
//  Comment.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 4.11.2021.
//

import Foundation

class Comment: Codable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
