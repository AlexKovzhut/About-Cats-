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
    var catsImageView: catsImageView! {
        didSet {
            catsImageView.contentMode = .scaleAspectFit
            catsImageView.clipsToBounds = true
            catsImageView.layer.cornerRadius = catsImageView.bounds.height / 2
            catsImageView.backgroundColor = .white
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with result: Result?) {
        nameLabel.text = result?.name
        catsImageView.fetchImage(from: result?.image.url ?? "")
    }
}
