//
//  Errors.swift
//  iTunesSearch
//
//  Created by mac on 23.05.2022.
//

import Foundation

enum StoreItemErrors: Error, LocalizedError {
    case itemsNotFound
    case imageDataMissing
}
