//
//  ViewController.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 25.05.2021.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Private properties
    private var cats: Cats?
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredAnimal: [Result] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setupSearchController()
        setupStyle()
        setupLayout()
        fetchData(from: URLS.catsAPI.rawValue)
    }
    
    // MARK: - Bar Button Actions
    @objc private func leftBarButtonPressed() {
        print(#function)
    }
    
    @objc private func updateBarButtonPressed() {
        print(#function)
    }
    
    
}

    // MARK: - Private Methods
extension TableViewController {
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        let leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .organize,
            target: self,
            action: #selector(leftBarButtonPressed)
        )
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(updateBarButtonPressed)
        )
        
        titleLabel.text = "Table View"
        leftBarButtonItem.tintColor = .black
        rightBarButtonItem.tintColor = .black
                
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.titleView = titleLabel
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }
    
    private func setupStyle() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.rowHeight = 100
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  cats in
            DispatchQueue.main.async {
                self.cats = cats
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredAnimal.count : cats?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        let result = isFiltering ? filteredAnimal[indexPath.row] : cats?.results[indexPath.row]
        cell.configure(with: result)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let cat = isFiltering ? filteredAnimal[indexPath.row] : cats?.results[indexPath.row]
        let detailVC = DetailViewController()
        show(detailVC, sender: self)
        detailVC.animalURL = cat?.image.url
    }
}

// MARK: - UISearchResultsUpdating
extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredAnimal = cats?.results.filter { chracter in
            chracter.name.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
}
