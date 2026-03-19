//
//  SplashView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 03/03/26.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad

        if isActive {
            MainTabView()
        } else {
            VStack {
                Image("freshyzo_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: isPad ? 260 : 150)
                    .scaleEffect(scale)
                    .opacity(opacity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .onAppear {
                
                withAnimation(.easeIn(duration: 1.2)) {
                    scale = 1.0
                    opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
