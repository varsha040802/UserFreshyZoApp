//
//  balanceCard.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 25/03/26.
//

import SwiftUI

struct balanceCard: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
               
               LinearGradient(
                   colors: [Color.green, Color.green.opacity(0.7)],
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing
               )
               .cornerRadius(16)
               
               VStack(alignment: .leading, spacing: 12) {
                   
                   Text("ACTIVE")
                       .font(.caption)
                       .padding(6)
                       .background(Color.white.opacity(0.2))
                       .cornerRadius(6)
                   
                   Text("Current Balance")
                       .foregroundColor(.white.opacity(0.8))
                   
                   Text("₹\(Int(vm.balance))")
                       .font(.title.bold())
                       .foregroundColor(.white)
                   
                   Text("Low balance – please recharge!")
                       .font(.caption)
                       .padding(8)
                       .background(Color.red.opacity(0.8))
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
               .padding()
           }
           .frame(height: 150)
    }
}

#Preview {
    balanceCard()
}
