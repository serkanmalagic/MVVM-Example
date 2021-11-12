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
    
    private var todoViewModel = TodoViewModel()

    @IBOutlet weak var triggerViewModelBtn: UIButton!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()
        
        todoViewModel.todos.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchData()
        
        setUpBindings()
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        setUpBindings()
    }
    
    @IBAction func triggerViewModelBtnTapped(_ sender: Any) {
        todoViewModel.updateViewModel()
    }
    
    //  Listening datas and do something
    func setUpBindings(){
        
        todoViewModel.title.bindTo(navigationController?.navigationBar.topItem, to: .title)
        
        todoViewModel.title.listen {
            self.headerLabel.text = $0
        }
        
        todoViewModel.backgroundColor.listen { color in
            self.tableView.backgroundColor = color
            self.triggerViewModelBtn.tintColor = color
            self.view.backgroundColor = color
        }
        
    }
    
    func fetchData (){
        NetworkClient.performRequest(vc: self, object: [Todo].self, router: APIRouter.getTodos, success : { result in
            
            self.todoViewModel.todos.value = result
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func setupTableView() {
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 1
        tableView.layer.shadowOffset = .zero
        tableView.layer.shadowRadius = 10
        tableView.layer.cornerRadius = 15
        headerView.layer.cornerRadius = 15
    }
}

extension TodoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = todoViewModel.todos.value?[indexPath.row].title
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 15)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todos.value?.count ?? 0
    }
    
}
