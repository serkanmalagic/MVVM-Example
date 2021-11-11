//
//  TodosViewModel.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 6.11.2021.
//

import Foundation
import UIKit

struct TodoViewModel {
    
    var todos = [Todo]()
    
    var backgroundColor : UIColor {
        return UIColor.random
    }
    var navigationTitle : String {
        return Lorem.firstName
    }
    var loadingIndicator : Bool {
        return false
    }
    
}
