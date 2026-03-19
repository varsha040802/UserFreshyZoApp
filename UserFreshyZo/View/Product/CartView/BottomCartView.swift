//
//  BottomCartView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 19/03/26.
//

import SwiftUI

struct BottomCartView: View {

    @EnvironmentObject var cartVM: CartViewModel
    @State private var showCart = false

    var body: some View {
        HStack {

            VStack(alignment: .leading, spacing: 4) {   // reduced spacing
                Text("\(cartVM.totalItems) items")
                    .font(.caption)
                    .foregroundColor(.white)

                Text("₹\(cartVM.totalPrice)")
                    .font(.headline)
                    .foregroundColor(.white)
            }

            Spacer()

            Button("View Cart") {
                showCart = true
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
            .foregroundColor(Color("AppGreenColor"))
            .cornerRadius(10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                  .fill(Color("AppGreenColor"))
                  .shadow(radius: 8)
        )
        .sheet(isPresented: $showCart) {
            CartView()
                .environmentObject(cartVM)
        }
    }
}
