//
//  DetailViewController.swift
//  AboutCats
//
//  Created by Alexander Kovzhut on 25.12.2021.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Private properties
    private let backgroundView = UIView()
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setupStyle()
        setupLayout()
    }
}

    // MARK: - Private Methods
extension DetailViewController {
    private func setup() {
        
    }
    
    private func setupNavigationBar() {
        
    }
    
    private func setupStyle() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .lightGray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "xmark.app")
    }
    
    private func setupLayout() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            backgroundView.pin(to: view),
            
            imageView.
        ])
    }
}
