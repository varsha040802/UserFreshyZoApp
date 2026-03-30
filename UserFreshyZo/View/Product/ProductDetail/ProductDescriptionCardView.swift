//
//  ratingsCard.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 30/03/26.
//

//  ProductDescriptionCardView.swift
//  UserFreshyZo

import SwiftUI

struct ProductDescriptionCardView: View {
    let isPad: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Description")
            Text("Introducing our 100% Preservative-Free A2 Gir Cow milk! Sourced from the finest Indian Gir Cows, this milk is rich in protein and calcium, making it an ideal choice for individuals of all ages. With its A2 beta-casein protein, it's easy on digestion, making it a great option for those with lactose intolerance. Perfect for growing children, expecting mothers, and senior citizens seeking a wholesome dairy alternative.")
                .font(.system(size: isPad ? 16 : 14))
                .foregroundColor(.secondary)
                .lineSpacing(4)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(["🌿 Organic", "🐄 Gir Breed", "🧪 Lab Tested", "♻️ Glass Bottle"],
                            id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: isPad ? 14 : 12, weight: .medium))
                            .padding(.horizontal, 12).padding(.vertical, 6)
                            .background(Color("AppGreenColor").opacity(0.1))
                            .foregroundColor(Color("AppGreenColor"))
                            .cornerRadius(20)
                    }
                }
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white))
        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
    }
}
