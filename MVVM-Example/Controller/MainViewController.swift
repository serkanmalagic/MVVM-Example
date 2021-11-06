//
//  MainViewController.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 4.11.2021.
//

import UIKit

class MainViewController: UIViewController {

    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var albumViewModel = AlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        albumViewModel.albums.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchData()
    }
    
    func fetchData (){
        NetworkClient.performRequest(vc: self, object: [Album].self, router: APIRouter.getAlbums, success : { result in
            
            self.albumViewModel.albums.value = result
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

extension MainViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        
        cell.textLabel?.text = albumViewModel.albums.value?[indexPath.row].title
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 25)

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.albums.value?.count ?? 0
    }
    
}
