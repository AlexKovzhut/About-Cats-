//
//  DetailViewController.swift
//  AboutCats
//
//  Created by Alexander Kovzhut on 25.12.2021.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Private properties
    private let scrollView = UIScrollView()
    private let imageView = BreedImageView()
    private let activityIndicator = UIActivityIndicatorView()
    private let nameLabel = UILabel()
    private let originLabel = UILabel()
    private let temperamentLabel = UILabel()
    
    private var breed: BreedElement?
    private var breedURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setupStyle()
        setupLayout()
        fetchData()
    }
}

    // MARK: - Private Methods
extension DetailViewController {
    private func setup() {
        
    }
    
    private func setupNavigationBar() {
        
    }
    
    private func setupStyle() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
        //scrollView.alwaysBounceHorizontal = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.style = .large
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "xmark.app")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        
        temperamentLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(originLabel)
        scrollView.addSubview(temperamentLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 15),
        ])
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchBreed(from: breedURL) { breed in
            self.breed = breed
            self.nameLabel.text = breed.name
            self.originLabel.text = breed.origin
            self.temperamentLabel.text = breed.temperament
            
            DispatchQueue.main.async {
                self.imageView.fetchImage(from: (breed.image?.url)!)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
