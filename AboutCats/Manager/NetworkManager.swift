//
//  NetworkManager.swift
//  About Cats!
//
//  Created by Alexander Kovzhut on 22.12.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchBreeds(with complition: @escaping ([BreedElement]) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let breeds = try JSONDecoder().decode([BreedElement].self, from: data)
                DispatchQueue.main.async {
                    complition(breeds)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchBreed(from url: String, completion: @escaping(BreedElement) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no descripption")
                return
            }
            
            do {
                let breed = try JSONDecoder().decode(BreedElement.self, from: data)
                DispatchQueue.main.async {
                    completion(breed)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
