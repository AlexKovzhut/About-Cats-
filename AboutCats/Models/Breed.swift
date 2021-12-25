//
//  Cats.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 22.12.2021.
//

struct BreedElement: Codable {
    let name: String
    let image: BreedImage?
    let origin: String
    let temperament: String
}

struct BreedImage: Codable {
    let url: String?
    
}




