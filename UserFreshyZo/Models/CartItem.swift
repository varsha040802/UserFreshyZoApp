//
//  CartItem.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 19/03/26.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id: String
    var quantity: Int
    let name: String
    let price: Int
}
