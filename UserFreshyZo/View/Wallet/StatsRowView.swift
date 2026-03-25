//
//  statsRow.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 25/03/26.
//

import SwiftUI

struct statsRow: View {
    var body: some View {
        HStack(spacing: 12) {
               statItem(title: "Total Added", value: vm.totalAdded)
               statItem(title: "Total Spent", value: vm.totalSpent)
               statItem(title: "Cashback", value: vm.cashback)
           }
    }
}

func statItem(title: String, value: Double) -> some View {
    VStack {
        Text(title)
            .font(.caption)
            .foregroundColor(.gray)
        
        Text("₹\(Int(value))")
            .font(.headline)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color.white)
    .cornerRadius(12)
}

#Preview {
    statsRow()
}
