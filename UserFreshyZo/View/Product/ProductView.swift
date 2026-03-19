//
//  ProductView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 04/03/26.
//

import SwiftUI

struct ProductView: View {
    
    @Binding var selectedTab: Int
    @StateObject private var vm = ProductViewModel()
    @State private var selectedCategory = "Milk"

    var body: some View {
        
        VStack(spacing: 0) {
            
            ProductHeaderView(selectedTab: $selectedTab,
                              vm: vm)
            
            DeliveryBannerView()
            
            HStack(spacing: 0) {
                
                CategorySidebarView(
                    vm: vm,
                    selectedCategory: $selectedCategory
                )

                ProductListView(
                    vm: vm,
                    selectedCategory: $selectedCategory
                )
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
        .onAppear{
            vm.fetchProducts()
            vm.fetchMockCategories()
        }
    }
}

#Preview {
    ProductView(selectedTab: .constant(0))
}
