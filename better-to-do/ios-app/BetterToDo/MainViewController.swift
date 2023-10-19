//
//  ViewController.swift
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    private var items = [ToDoItem]()
    private let service = ToDoService()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")


        service.fetchAll { items, error in
            print(items)
            print(error)
            guard let items, error == nil else {
                return
            }
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        let item = items[indexPath.row]
        var configuration = UIListContentConfiguration.cell()
        configuration.text = item.content
        if item.isDone {
            configuration.image = UIImage(systemName: "checkmark")
        }
        cellView.contentConfiguration = configuration
        return cellView
    }
}
