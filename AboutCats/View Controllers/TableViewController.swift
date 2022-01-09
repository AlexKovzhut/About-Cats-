//
//  ViewController.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 25.05.2021.
//

import UIKit

class TableViewController: UIViewController {
    // MARK: - Private properties
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var breedColletion: [BreedElement]?
    private var filteredBreed: [BreedElement] = []
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
        fetchData()
    }
    
    // MARK: - Bar Button Actions
    @objc private func leftBarButtonPressed() {
        print(#function)
    }
    
    @objc private func updateBarButtonPressed() {
        print(#function)
        tableView.reloadData()
    }
}

    // MARK: - Private Methods
extension TableViewController {
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavigationBar() {
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
        
        leftBarButtonItem.tintColor = .black
        rightBarButtonItem.tintColor = .black
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "About cats!"
        
        navigationItem.searchController = searchController
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find a cat breed..."
        searchController.searchBar.backgroundColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .systemPink
        }
    }
    
    private func setupStyle() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.rowHeight = 120
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.pin(to: view)
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchBreeds() { breed in
            DispatchQueue.main.async {
                self.breedColletion = breed
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredBreed.count : breedColletion?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        let searchResult = isFiltering ? filteredBreed[indexPath.row] : breedColletion?[indexPath.row]
        cell.configure(with: searchResult!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let breed = isFiltering ? filteredBreed[indexPath.row] : breedColletion?[indexPath.row]
        
        let destinationController = DetailViewController()
        destinationController.breed = breed
        
        let navigationController = UINavigationController()
        navigationController.addChild(destinationController)
        
        self.navigationController?.isNavigationBarHidden = false
        self.modalPresentationStyle = .pageSheet
        self.modalTransitionStyle = .coverVertical
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating
extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredBreed = breedColletion?.filter { chracter in
            chracter.name.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
}
