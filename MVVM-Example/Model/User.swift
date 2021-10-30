//
//  User.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 30.10.2021.
//

import Foundation
import UIKit

class User {
    let name : String
    let backgroundColor : UIColor
    
    internal init(name: String, backgroundColor: UIColor) {
        self.name = name
        self.backgroundColor = backgroundColor
    }
}
