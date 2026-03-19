//
//  HomeViewModel.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 21/02/26.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject{
    @Published var banners: [Banner] = []
    @Published var categories: [Category] = []
    @Published var offers: [Offer] = []
    @Published var articles: [Artical] = []
    
    init(){
        loadMockData()
    }
    
    func loadMockData() {
        
        banners = [
               Banner(
                   id: 1,
                   name: "Banner1",
                   image: "https://static1.squarespace.com/static/638d8044b6fc77648ebcedba/t/67a5b74af834d07712692f36/1738913639066/Top+10+dairy+products+for+your+kitchen+-+Kota+Fresh+Dairy.png?format=1500w"
               ),
               Banner(
                   id: 2,
                   name: "Banner2",
                   image: "https://images.squarespace-cdn.com/content/v1/638d8044b6fc77648ebcedba/7d7c7c4f-34b6-4381-b8ad-d88433c86f62/4.png"
               ),
               Banner(
                   id: 3,
                   name: "Banner3",
                   image: "https://asset7.ckassets.com/blog/wp-content/uploads/sites/5/2021/12/Best-Milk-Brands.jpg"
               )
           ]
        
      categories = [
        Category(id: 1, name: "All Products", image: "category1"),
        Category(id: 2, name: "Milk Products", image: "category2"),
        Category(id: 3, name: "Dahi Products", image: "category3"),
        Category(id: 4, name: "Ghee Products", image: "category2")

      ]
        
        
        offers = [
            Offer(id: 1, title: "Milk and Ghee", subtitle: "buy ghee and paneer", price: 1000, image: "milk_ghee"),
            Offer(id: 2, title: "Paneer and Dahi", subtitle: "buy ghee and paneer", price: 500, image: "paneer_dahi"),
            Offer(id: 3, title: "Milk and Khowa", subtitle: "buy milk and khowa", price: 1000, image: "milk_khowa")
        ]
        
        articles = [
            Artical(
                  id: 1,
                  title: "Free Grazing vs Shed",
                  description: "Free Grazing vs Shed Free Grazing vs Shed Free Grazing vs Shed",
                  image: "https://images.unsplash.com/photo-1567306226416-28f0efdc88ce"
              ),
            Artical(
                  id: 2,
                  title: "Buffalo Milk Benefits",
                  description: "Free Grazing vs Shed Free Grazing vs Shed Free Grazing vs Shed",
                  image: "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b"
              )
          ]
    }
    
    func fetchHomeData(){
        // APIService.shared.fetchHome()
    }
}
