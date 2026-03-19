//
//  ButtonQtyStepper.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 19/03/26.
//


import SwiftUI
import Combine

struct ButtonQtyStepper: View {

    let id: String
    let name: String
    let price: Int

    @EnvironmentObject var cartVM: CartViewModel

    var quantity: Int {
        cartVM.items.first(where: { $0.id == id })?.quantity ?? 0
    }

    var body: some View {
        HStack(spacing: 8) {

                   if quantity == 0 {
                       Button {
                           cartVM.addItem(id: id, name: name, price: price)
                       } label: {
                           Text("Buy Once")
                               .font(.caption)               // 👈 smaller font
                               .padding(.vertical, 6)        // 👈 small padding
                               .padding(.horizontal, 8)
                       }
                       .overlay(
                           RoundedRectangle(cornerRadius: 5)
                               .stroke(Color.green, lineWidth: 1)
                       )
                       .foregroundColor(.green)

                   } else {
                       HStack(spacing: 6) {

                           Button {
                               cartVM.removeItem(id: id)
                           } label: {
                               Text("-")
                                   .font(.caption)
                                   .frame(width: 24, height: 24)
                           }
                           .overlay(
                               RoundedRectangle(cornerRadius: 5)
                                   .stroke(Color.green, lineWidth: 1)
                           )
                           .foregroundColor(.green)

                           Text("\(quantity)")
                               .font(.caption)

                           Button {
                               cartVM.addItem(id: id, name: name, price: price)
                           } label: {
                               Text("+")
                                   .font(.caption)
                                   .frame(width: 24, height: 24)
                           }
                           .overlay(
                               RoundedRectangle(cornerRadius: 5)
                                   .stroke(Color.green, lineWidth: 1)
                           )
                           .foregroundColor(.green)
                       }
                   }

                   // Subscribe Button (same as before)
                   Button {
                       print("Subscribe tapped")
                   } label: {
                       Text("Subscribe")
                           .font(.caption)
                           .padding(.vertical, 6)
                           .padding(.horizontal, 8)
                   }
                   .background(Color.green)
                   .cornerRadius(5)
                   .foregroundColor(.white)
               }
    }
}



extension View {
    func outlinedButton() -> some View {
        self
            .font(.headline)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.green, lineWidth: 1.5)
            )
            .foregroundStyle(Color.green)
    }

    func filledButton() -> some View {
        self
            .font(.headline)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.green)
            )
            .foregroundStyle(Color.white)
    }

    func circleButton() -> some View {
        self
            .font(.headline)
            .frame(width: 36, height: 36)
            .background(
                Circle()
                    .stroke(Color.green, lineWidth: 1.5)
            )
            .foregroundStyle(Color.green)
    }
}

#Preview {
    ButtonQtyStepper(id: "102", name: "A2 Cow Milk", price: 45)
        .environmentObject(CartViewModel())
}
