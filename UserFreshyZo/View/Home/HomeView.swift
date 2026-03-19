//
//  ContentView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 21/02/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: isPad ? 40 : 30) {
                        BannerCarouselView(banners: vm.banners)
                            .padding(.top, 16) 
                        CategoryGridView(categories: vm.categories)
                        MilkTestReportCard()
                        ComboOfferSection(offers: vm.offers)
                        ArticleSection(articles: vm.articles)
                        SuggestionView()
                        BottomBrandingView()   
                    }
                    .padding(.horizontal, isPad ? 20 : 16)
                    .padding(.bottom, 30)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeView()
}
