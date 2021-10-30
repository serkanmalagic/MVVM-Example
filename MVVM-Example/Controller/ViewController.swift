//
//  ViewController.swift
//  Jenkins
//
//  Created by Serkan Mehmet Malagiç on 15.10.2021.
//

import UIKit
import Alamofire
import SCLAlertView

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var userViewModel : UserViewModel! {
        didSet{
            UIView.transition(with: self.view, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.navigationItem.title = self.userViewModel.user.name
                self.view.backgroundColor = self.userViewModel.user.backgroundColor
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func setViewModel(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            createUser(.red, "Serkan red")
        case 1:
            createUser(.green, "Serkan green")
        case 2:
            createUser(.blue, "Serkan blue")
        default:
            break
        }
    }
    
    func createUser(_ color : UIColor , _ title : String){
        let user = User(name: title, backgroundColor: color)
        userViewModel = UserViewModel(user: user)
    }
    
}

