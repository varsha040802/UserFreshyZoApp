//
//  ProductListView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 04/03/26.
//

import SwiftUI

// MARK: - PreferenceKey (same file me)
struct CategoryPositionKey: PreferenceKey {
    
    static var defaultValue: [String: CGFloat] = [:]

    static func reduce(value: inout [String : CGFloat], nextValue: () -> [String : CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}


struct ProductListView: View {
    @State private var isUserScrolling = true
    @ObservedObject var vm : ProductViewModel
    @Binding var selectedCategory : String

    let categoryOrder = ["Milk", "Dahi", "khowa", "Paneer", "Ghee"]

    // GROUP PRODUCTS BY CLEAN CATEGORY
        var groupedProducts: [String: [Product]] {
            Dictionary(grouping: vm.products) { $0.cleanCategory }
        }
    
    var body: some View {
        
        let isPad = UIDevice.current.userInterfaceIdiom == .pad

        ScrollViewReader { proxy in
            ScrollView {
                
                LazyVStack(alignment: .leading, spacing: 0) {
                                    
                    ForEach(categoryOrder, id: \.self) { category in
                                        
                        if let products = groupedProducts[category] {
                            
                            VStack(spacing: 0) {
                                
                                // ⭐ anchor + scroll tracker
                                Color.clear
                                    .frame(height: 1)
                                    .id(category)
                                    .overlay(
                                        GeometryReader { geo in
                                            Color.clear.preference(
                                                key: CategoryPositionKey.self,
                                                value: [category: geo.frame(in: .named("scroll")).minY]
                                            )
                                        }
                                    )
                                
                                ForEach(products, id: \.id) { product in
                                    ProductCardView(product: product)
                                        .padding(.bottom, isPad ? 20 : 16)

                                }
                            }
                        }
                    }
                }
                .padding(.leading, 4)
                .padding(.trailing, 12)
                .padding(.top, isPad ? 20 : 12)
            }
            .coordinateSpace(name: "scroll")

            // Category click → scroll product
            .onChange(of: selectedCategory) { _, newValue in
                
                isUserScrolling = false
                
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .top)
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    isUserScrolling = true
                }
            }
        }
        // Product scroll → sidebar highlight
        .onPreferenceChange(CategoryPositionKey.self) { values in

            guard isUserScrolling else { return }

            if let category = values.min(by: { abs($0.value) < abs($1.value) })?.key,
                selectedCategory != category {
                selectedCategory = category
            }
        }
        .onAppear{
            
            vm.fetchProducts()
        }
    }
}
