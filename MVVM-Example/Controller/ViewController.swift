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

struct UserListViewModel {
    //  Genericlerle çalışıyorsanırz açılı brackets kullanmayı unutmayın
    var users: Observable<[UserTableViewCellViewModel]> = Observable([])
}

struct UserTableViewCellViewModel {
    let name : String
}

class ViewController: UIViewController {
    
    private let tableView : UITableView = {
        let table = UITableView()
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private var viewModel = UserListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        //  Değer apiden çağırıldığında değişime uğradığında listener değeri bekler ve değiştiği anda tableView reload edilir
        viewModel.users.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchData()
    }
    
    func fetchData (){
        NetworkClient.performRequest(vc: self, object: [User].self, router: APIRouter.getUsers, success : { result in
            
            self.viewModel.users.value = result.compactMap({
                UserTableViewCellViewModel(name : $0.name)
            })
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
   
    
}

//  Muhatapımız sadece viewmodel olacak
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.users.value?[indexPath.row].name
        return cell
    }
}

