//
//  MainViewController.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 4.11.2021.
//

import UIKit

class MainViewController: UIViewController {

    var commentViewModel : CommentViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentViewModel.loadComments(vc: self) {
            print(commentViewModel.comments)
        }
        
    }

}

extension MainViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        
        cell.textLabel?.text = commentViewModel.comments?[indexPath.row].body
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentViewModel.numberOfRowsInSectionCount()
    }
    
}
