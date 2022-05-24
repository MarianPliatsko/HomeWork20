//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by mac on 23.05.2022.
//

import Foundation
import UIKit

class StoreItemController {
    
    // MARK: - Methods
    
    func fetchItems(query: [String:String]) async throws -> [StoreItem] {
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map {URLQueryItem(name: $0.key, value: $0.value)}
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw StoreItemErrors.itemsNotFound
        }
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        
        return searchResponse.results
    }

    func fetchImage(from url: URL) async throws -> UIImage {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw StoreItemErrors.imageDataMissing
        }
        guard let image = UIImage(data: data) else {
            throw StoreItemErrors.itemsNotFound
        }
        return image
    }
}
