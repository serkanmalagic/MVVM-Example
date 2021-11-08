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
        
        navigationItem.largeTitleDisplayMode = .always
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        todoViewModel.todos.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchItems()
        
    }
    
    @IBAction func bindingTriggerTapped(_ sender: Any) {
        fetchItems()
    }
    
    func fetchItems(){
        
        var strArr = [String]()
        for _ in 0 ..< 10 { strArr.append(Lorem.sentences(2)) }
        self.todoViewModel.todos.value = strArr
        print("çalıştım")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            var strArr = [String]()
            for _ in 0 ..< 40 { strArr.append(Lorem.paragraphs(1)) }
            self.todoViewModel.todos.value = strArr
            print("çalıştım")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                var strArr = [String]()
                for _ in 0 ..< 100 { strArr.append(Lorem.tweet) }
                self.todoViewModel.todos.value = strArr
                print("çalıştım")
            }
        }
    }
}

extension TodoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = todoViewModel.todos.value?[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 15)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todos.value?.count ?? 0
    }
    
}
