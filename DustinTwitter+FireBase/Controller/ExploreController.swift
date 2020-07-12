//
//  ExploreController.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/04/30.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

private let reuseIdetifier = "UserCell"

class ExploreController: UITableViewController {
    //MARK: - Properties
    
    private var users = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private var filterUsers = [User]() {
        didSet {tableView.reloadData()}
    }
    private var inSearchMode: Bool {
        return searchController.isActive &&                         ((searchController.searchBar.text?.isEmpty) != nil)
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
       fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    //MARK: - API
    func fetchUsers() {
        UserService.shared.fetchUsers { users in
            self.users = users
        }
    }
    
    //MARK: - Helpers
    
        func configureUI() {
            view.backgroundColor = .white
            navigationItem.title = "Explore"
            
            tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdetifier)
            tableView.rowHeight = 60
            tableView.separatorStyle = .none
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
    }
}

//MARK : - UItableViewDelegate / DataSource
extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filterUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdetifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        
        cell.user = user
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        let controller = profileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
}

extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filterUsers = users.filter({$0.username.contains(searchText) || $0.fullname.contains(searchText)})

        tableView.reloadData()
    }
    
    
}
