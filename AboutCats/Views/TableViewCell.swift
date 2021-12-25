//
//  TableViewCell.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 22.12.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: - Public properties
    static let identifier = "identifier"
    let stuckView = UIStackView()
    let nameLabel = UILabel()
    let originLabel = UILabel()
    var breedImageView = BreedImageView()
    
    // MARK: - UITableViewCell Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setStyle() {
        stuckView.translatesAutoresizingMaskIntoConstraints = false
        stuckView.spacing = 6
        stuckView.axis = .vertical
        stuckView.alignment = .leading
        stuckView.distribution = .fillProportionally
        
        breedImageView.translatesAutoresizingMaskIntoConstraints = false
        breedImageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = UIColor.systemPink
        nameLabel.shadowColor = UIColor.systemPink
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        originLabel.textColor = UIColor.systemPink
        originLabel.shadowColor = UIColor.systemPink
        originLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
        
    private func setLayout() {
        contentView.addSubview(breedImageView)
        contentView.addSubview(stuckView)
        
        stuckView.addArrangedSubview(nameLabel)
        stuckView.addArrangedSubview(originLabel)
            
        NSLayoutConstraint.activate([
            breedImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            breedImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            breedImageView.heightAnchor.constraint(equalToConstant: 110),
            breedImageView.widthAnchor.constraint(equalTo: breedImageView.heightAnchor, multiplier: 16/12),
            
            stuckView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stuckView.leadingAnchor.constraint(equalTo: breedImageView.trailingAnchor, constant: 8),
            stuckView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func configure(with breed: BreedElement) {
        nameLabel.text = breed.name
        originLabel.text = breed.origin
        breedImageView.fetchImage(from: breed.image?.url ?? "")
    }
}
