//
//  CartViewModel.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 19/03/26.
//
import Foundation
import Combine

class CartViewModel: ObservableObject {

    @Published var items: [CartItem] = [] {
            didSet {
                saveCart()   // ✅ auto save whenever cart changes
            }
        }

        private let key = "cart_items"

        // MARK: - Init (load saved cart)
        init() {
            loadCart()
        }


    // MARK: - Add Item
    func addItem(id: String, name: String, price: Int) {

        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].quantity += 1
        } else {
            let newItem = CartItem(
                id: id,
                quantity: 1,  
                name: name,
                price: price
            )
            items.append(newItem)
        }
    }

    // MARK: - Remove Item
    func removeItem(id: String) {

        guard let index = items.firstIndex(where: { $0.id == id }) else { return }

        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }
    
    // MARK: - Save Cart
    private func saveCart() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    // MARK: - Load Cart
    private func loadCart() {
        if let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode([CartItem].self, from: data) {
            items = decoded
        }
    }

    // MARK: - Total Items
    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    // MARK: - Total Price
    var totalPrice: Int {
        items.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
}
