//
//  ChatsViewController.swift
//  Tinderque-View
//
//  Created by Mike S. on 24/01/2024.
//

import UIKit

final class ChatsViewController: UIViewController {

    private let tableView = UITableView()

    init() {
        super.init(nibName: nil, bundle: nil)

        tabBarItem = UITabBarItem(title: nil,
                                  image: UIImage(systemName: "bubble.fill"),
                                  tag: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        tableView.register(ChatTableViewCell.self,
                           forCellReuseIdentifier: "test")
        tableView.register(MatchesTableViewCell.self,
                           forCellReuseIdentifier: "test2")
        tableView.dataSource = self
        tableView.delegate = self


        //tableView.rowHeight = 96
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 15
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "test2", for: indexPath) as? MatchesTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }

        cell.name = "Test"
        cell.lastMessage = "Lorem ipsum blablablabla"
        cell.userImage = ProfileService.shared.getImages().first
        return cell
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
         switch section {
         case 0:
             return "Matches"
         case 1:
             return "Messages"
         default:
             return nil
         }
    }
}

extension ChatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160.0
        }
        return 96.0
    }
}

#Preview {
    UINavigationController(rootViewController: ChatsViewController())

}
