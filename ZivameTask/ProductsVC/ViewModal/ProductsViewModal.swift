//
//  ProductsViewModal.swift
//  ZivameTask
//
//  Created by Raviteja Mathangi on 23/12/21.
//

import Foundation
struct ProductsViewModal{
    var name: String?
    var imageURL: String?
    var price: String?
    var rating: Int?
    init(productInit: Product) {
        self.name = productInit.name
        self.imageURL = productInit.imageURL
        self.price = productInit.price
        self.rating = productInit.rating
    }
}
