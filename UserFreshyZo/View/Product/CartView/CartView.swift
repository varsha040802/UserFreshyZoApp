//
//  CartView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 19/03/26.
//

import SwiftUI

struct CartView: View {

    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        List {
            ForEach(cartVM.items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text("Qty: \(item.quantity)")
                    Text("₹\(item.price * item.quantity)")
                }
            }
        }
    }
}

#Preview {
    CartView()
}
