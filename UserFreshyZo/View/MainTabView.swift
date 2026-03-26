//
//  MainTabView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 21/02/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showCart = false
    @EnvironmentObject var cartVM: CartViewModel
    
    var shouldShowCart: Bool {
        showCart && (selectedTab == 0 || selectedTab == 1)
    }

    var body: some View {
        
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
                    
                    WalletView()
                        .tabItem {
                            Image(systemName: "creditcard.fill")
                            Text("Wallet")
                        }
                        .tag(2)
                    
                    Text("Account")
                        .tabItem{
                            Image(systemName: "person.fill")
                            Text("Account")
                        }
                        .tag(3)
                    
                    CartView(selectedTab: $selectedTab)
                        .tabItem{
                            Image(systemName: "cart")
                            Text("Cart")
                        }
                        .tag(4)
                }
                .accentColor(.green)
                
            }
          
            .safeAreaInset(edge: .bottom, spacing: 0) {
                BottomCartView(selectedTab: $selectedTab)
                    .padding(.horizontal, 16)
                    .offset(y: shouldShowCart ? -60 : 120)
                    .opacity(shouldShowCart ? 1 : 0)
//                    .animation(.easeInOut(duration: 0.25), value: shouldShowCart)
            }
        
            .onAppear {
                showCart = cartVM.totalItems > 0
            }
        
            .onChange(of: cartVM.totalItems) { _, newValue in
                withAnimation(.easeInOut(duration: 0.35)) {
                    showCart = newValue > 0
                }
            }
    }
}

#Preview {
    MainTabView()
}
