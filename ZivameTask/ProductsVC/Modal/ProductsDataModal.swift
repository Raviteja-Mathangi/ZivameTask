//
//  ProductsDataModal.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 23/12/21.
//

import Foundation

// MARK: - Products
struct Products: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let name, price: String
    let imageURL: String
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case name, price
        case imageURL = "image_url"
        case rating
    }
}

