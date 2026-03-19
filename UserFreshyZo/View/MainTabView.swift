//
//  MainTabView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 21/02/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            NavigationStack{
                
                TabView(selection: $selectedTab){
                    HomeView()
                        .tabItem{
                            Image(systemName: "house.fill")
                            Text("Home")
                            
                        } .tag(0)
                    
                    ProductView(selectedTab: $selectedTab)
                        .tabItem{
                            Image(systemName: "bag")
                            Text("products")
                        }
                        .tag(1)
                    
                    Text("Wallet")
                        .tabItem{
                            Image(systemName: "person")
                            Text("Account")
                        }
                        .tag(3)
                    
                    Text("Cart")
                        .tabItem{
                            Image(systemName: "cart")
                            Text("Cart")
                        }
                        .tag(4)
                }
                .accentColor(.green)
                
            }
            if cartVM.totalItems > 0 {
                   BottomCartView()
                       .padding(.horizontal, 16)
                       .padding(.bottom, 70)
                       .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut, value: cartVM.totalItems)
    }
}

#Preview {
    MainTabView()
}
