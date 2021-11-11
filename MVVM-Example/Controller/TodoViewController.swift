//
//  TodoViewController.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 6.11.2021.
//

import UIKit

class TodoViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var todoViewModel = TodoViewModel() {
        didSet{
            self.tableView.reloadData()
            self.tableView.backgroundColor = todoViewModel.backgroundColor
            self.headerView.backgroundColor = todoViewModel.backgroundColor
            for item in todoViewModel.todos {
                print(item.title)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
                        
    }
    
    @IBAction func bindingTriggerTapped(_ sender: Any) {
        setItems()
    }
    
    func setItems(){
        NetworkClient.performRequest(vc: self, object: [Todo].self, router: APIRouter.getTodos) { result in
            self.todoViewModel.todos = result
        } failure: { error in
            print(error.localizedDescription)
        }
    }
}

extension TodoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = todoViewModel.todos[indexPath.row].title
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 15)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todos.count
    }
    
}
