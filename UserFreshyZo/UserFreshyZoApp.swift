//
//  UserFreshyZoApp.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 21/02/26.
//

import SwiftUI

@main
struct UserFreshyZoApp: App {

    @StateObject var cartVM = CartViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(cartVM) 
                .preferredColorScheme(.light)
        }
    }
}
