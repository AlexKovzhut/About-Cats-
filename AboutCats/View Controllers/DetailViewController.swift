//
//  DetailViewController.swift
//  AboutCats
//
//  Created by Alexander Kovzhut on 25.12.2021.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Private properties
    private let backgroundScrollView = UIScrollView()
    private let imageView = BreedImageView()
    private let activityIndicator = UIActivityIndicatorView()
    private let nameLabel = UILabel()
    private let originLabel = UILabel()
    private let temperamentLabel = UILabel()
    
    var breed: BreedElement?
    
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
        backgroundScrollView.translatesAutoresizingMaskIntoConstraints = false
        backgroundScrollView.alwaysBounceVertical = true
        backgroundScrollView.backgroundColor = .white
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.style = .large
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        
        temperamentLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        view.addSubview(backgroundScrollView)
        backgroundScrollView.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        backgroundScrollView.addSubview(nameLabel)
        backgroundScrollView.addSubview(originLabel)
        backgroundScrollView.addSubview(temperamentLabel)
        
        NSLayoutConstraint.activate([
            backgroundScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: backgroundScrollView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: backgroundScrollView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: backgroundScrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: backgroundScrollView.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: backgroundScrollView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: backgroundScrollView.centerYAnchor)
        ])
    }
    
    private func fetchData() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        nameLabel.text = breed?.name
        
        DispatchQueue.main.async {
            
        }
    }
}
