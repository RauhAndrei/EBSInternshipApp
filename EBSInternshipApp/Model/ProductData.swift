//
//  ProductModel.swift
//  EBSInternshipApp
//
//  Created by Rauh Andrei on 20.10.2021.
//

import Foundation

struct Root : Codable {
    let results : [ProductData]
}

struct ProductData: Codable {
    let name: String
    let size: String
    let colour: String
    let price: Int
    let details: String
    let category: Category
}

struct Category: Codable {
    let icon: String
}
