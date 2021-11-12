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

    var isLoading = Var(true)
    let title = Var("The New App")
    let exampleImage = Var(UIImage(named: "example1"))
    let backgroundColor = Var(UIColor.systemPink)

    /**
     Example method to change the view model values and see the real time changes in the screen.
     */
    mutating func updateViewModel() {
        
        title.value = Lorem.sentences(1)
        exampleImage.value = UIImage(named: "example\(isLoading.value ? "1" : "2")")
        backgroundColor.value = UIColor.random
        
    }
    
    mutating func startIndicator () {
        isLoading.value = true
    }
    
    mutating func endIndicator () {
        isLoading.value = false
    }
}

