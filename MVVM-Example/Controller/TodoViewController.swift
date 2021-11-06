//
//  TodoViewController.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 6.11.2021.
//

import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var todoViewModel = TodoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        todoViewModel.todos.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchItems()
        
    }
    
    func fetchItems(){
        NetworkClient.performRequest(vc: self, object: [Todo].self, router: APIRouter.getTodos) { result in
            self.todoViewModel.todos.value = result
        } failure: { error in
            print(error.localizedDescription)
        }
    }
}

extension TodoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = todoViewModel.todos.value?[indexPath.row].title
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 15)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todos.value?.count ?? 0
    }
    
}
