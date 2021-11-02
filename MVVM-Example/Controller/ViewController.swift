//
//  ViewController.swift
//  Jenkins
//
//  Created by Serkan Mehmet Malagiç on 15.10.2021.
//

import UIKit
import Alamofire
import SCLAlertView

//  RoadMap - Observable -> Model -> ViewModel -> Controller

//  Observable viewmodel binding işlemleri
class Observable<T> {
    
    //  T-Type'lar optional olarak tanımlanır. Viewmodel tanımlandığında başlangıç değeri nil olabilir.
    var value : T? {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value : T?){
        self.value = value
    }
    private var listener : ((T?) -> Void)?
    
    func bind(_ listener: ( @escaping (T?) -> Void)){
        listener(value)
        self.listener = listener
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

