//
//  ProductViewModel.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 05/03/26.
//

import Foundation
import Combine
class ProductViewModel: ObservableObject{
    
    @Published var products: [Product] = []
    @Published var categories: [CategorySidebar] = []
    
    // MARK: - Featch Products

    func fetchProducts() {
        
        guard let url = URL(string: "https://freshyzo.com/admin/Customer_App_Api/fetch_product") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error{
                print("Network error: ", error.localizedDescription)
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            
//            print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
            
            do {
                
                let decoded = try JSONDecoder().decode([Product].self, from: data)
                
                DispatchQueue.main.async {
                    self.products = decoded
                }
            } catch {
                print("Decoding error:", error)
            }
            
        }.resume()
    
    }
    
    // MARK: - Search Products
    func searchProducts(with text: String) -> [Product] {
        
        guard !text.isEmpty else { return [] }
        
        return products.filter {
            $0.productName.localizedCaseInsensitiveContains(text)
        }
    }
    
    // MARK: - Product Categories
    func fetchMockCategories() {
        
        categories = [
            CategorySidebar(id: "1", name: "Milk", image: "milk"),
            CategorySidebar(id: "2", name: "Dahi", image: "dahi"),
            CategorySidebar(id: "3", name: "khowa", image: "khowa"),
            CategorySidebar(id: "4", name: "Paneer", image: "paneer"),
            CategorySidebar(id: "5", name: "Ghee", image: "ghee")
              ]
    }
}
