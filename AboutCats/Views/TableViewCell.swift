//
//  TableViewCell.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 22.12.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "identifier"
    
    let nameLabel = UILabel()
    var breedImageView = BreedImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        breedImageView.translatesAutoresizingMaskIntoConstraints = false
        breedImageView.clipsToBounds = true
        breedImageView.contentMode = .scaleAspectFill
        
    }
        
    private func setLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(breedImageView)
            
        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            breedImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            breedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    
    func configure(with breed: BreedElement) {
        nameLabel.text = breed.name
        breedImageView.fetchImage(from: breed.image?.url ?? "")
    }
}
