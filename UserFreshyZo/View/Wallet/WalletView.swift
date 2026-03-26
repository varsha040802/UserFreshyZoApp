//
//  SwiftUIView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 24/03/26.
//

import SwiftUI

struct WalletView: View {
    
    @StateObject var vm = WalletViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            WalletHeaderView()
                .padding()
                .background(Color.white)
            
            ScrollView {
                VStack(spacing: 16) {
                    BalanceCardView(vm: vm)
                    StatsRowView(vm: vm)
                    RechargeSectionView(vm: vm)
                    HistorySectionView()
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    WalletView()
}
