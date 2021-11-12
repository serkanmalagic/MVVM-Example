//
//  TodosViewModel.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 6.11.2021.
//

import Foundation
import UIKit
import Alamofire
import EasyBinding

struct TodoViewModel {
    
    var todos: Observable<[Todo]> = Observable([])

    let isLoading = Var(true)
    let title = Var("The New App")
    let exampleImage = Var(UIImage(named: "example1"))
    let backgroundColor = Var(UIColor.lightGray)
    /**
     Example method to change the view model values and see the real time changes in the screen.
     */
    mutating func updateViewModel() {
        
        isLoading.value.toggle()
        title.value = "The \(isLoading.value ? "New" : "Old") App"
        exampleImage.value = UIImage(named: "example\(isLoading.value ? "1" : "2")")
        backgroundColor.value = UIColor.random
        
    }
}

