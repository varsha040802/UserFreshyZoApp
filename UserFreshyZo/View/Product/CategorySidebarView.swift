//
//  CategorySidebarView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 04/03/26.
//

import SwiftUI

struct CategorySidebarView: View {
    
    @ObservedObject var vm : ProductViewModel
    @Binding var selectedCategory: String
    
    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: isIPad ? 20 : 12) {
                
                ForEach(vm.categories) { category in
                    
                    VStack(spacing: 8) {
                        
                        Image(category.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: isIPad ? 80 : 40)
                        
                        Text(category.name)
                            .font(.system(size: isIPad ? 18 : 12))
                            .foregroundColor(.gray)
                    }
                    .frame(
                        width: isIPad ? 130 : 70,
                        height: isIPad ? 150 : 80
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 14)
//                            .fill(Color.white)
                            .fill(
                                selectedCategory == category.name ?
                                Color.green.opacity(0.08) : Color.white
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                selectedCategory == category.name ?
                                Color.green : Color.clear,
                                lineWidth: 1
                            )
                    )
                    .shadow(color: .black.opacity(0.06), radius: 3, y: 2)
                    .onTapGesture {
//                        selectedCategory = category
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCategory = category.name
                           }
                    }
                }
            }
            .padding(.vertical, 16)
        }
        .frame(width: isIPad ? 160 : 90)
        .background(Color(.systemGroupedBackground))
        .onAppear {
            vm.fetchMockCategories()
        }
    }
}
//
//#Preview {
//    CategorySidebarView()
//}
