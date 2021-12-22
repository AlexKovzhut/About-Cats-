//
//  Cats.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 22.12.2021.
//

struct Cats: Codable {
    let results: [Result]
}

struct Result: Codable {
    let name, temperament, origin, catsDescription: String
    let wikipediaURL: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case name, temperament, origin
        case catsDescription = "description"
        case wikipediaURL = "wikipedia_url"
        case image
    }
}

struct Image: Codable {
    let id: String
    let width, height: Int
    let url: String
}

enum URLS: String {
    case catsAPI = "https://api.thecatapi.com/v1/breeds"
}
