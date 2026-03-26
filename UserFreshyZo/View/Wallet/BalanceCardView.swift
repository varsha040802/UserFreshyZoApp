//
//  balanceCard.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 25/03/26.

import SwiftUI

struct BalanceCardView: View {
    @ObservedObject var vm: WalletViewModel

    var body: some View {
        ZStack(alignment: .topLeading) {

            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 0.18, green: 0.62, blue: 0.35),
                    Color(red: 0.25, green: 0.75, blue: 0.45)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(20)

            // Decorative circles
            Circle()
                .fill(Color.white.opacity(0.07))
                .frame(width: 140, height: 140)
                .offset(x: 180, y: -50)

            Circle()
                .fill(Color.white.opacity(0.05))
                .frame(width: 100, height: 100)
                .offset(x: 140, y: 20)

            // Wallet icon — top right
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.18))
                            .frame(width: 42, height: 42)

                        // Custom wallet SVG-style using SwiftUI shapes
                        WalletIconView()
                            .frame(width: 26, height: 22)
                    }
                }
                Spacer()
            }
            .padding(.top, 14)
            .padding(.trailing, 14)

            // Content
            VStack(alignment: .leading, spacing: 6) {

                // ACTIVE badge
                Text("ACTIVE")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.22))
                    .cornerRadius(7)

                // Label
                Text("Current Balance")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.white.opacity(0.85))

                // Balance amount
                Text("₹\(vm.balance, specifier: "%.0f")")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)

                Spacer()

                // Low balance pill
                HStack(spacing: 7) {
                    Circle()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: 6, height: 6)
                    Text("Low balance – please recharge!")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Color(red: 0.55, green: 0.18, blue: 0.12)
                        .opacity(0.85)
                )
                .cornerRadius(18)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .frame(height: 145)  // ⬅ reduced from 170
        .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 4)
    }
}

// MARK: - Custom Wallet Icon
struct WalletIconView: View {
    var body: some View {
        ZStack {
            // Wallet body
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.white.opacity(0.85))  // white
                .frame(width: 26, height: 18)
                .offset(y: 2)

            // Wallet flap (top fold)
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.white.opacity(0.65))  // slightly dimmer white
                .frame(width: 26, height: 10)
                .offset(y: -4)

            // Coin/card slot circle
            Circle()
                .fill(Color(red: 0.85, green: 0.65, blue: 0.10))  // gold coin
                .frame(width: 7, height: 7)
                .offset(x: 6, y: 3)

            // Card lines
            Capsule()
                .fill(Color.white.opacity(0.4))
                .frame(width: 12, height: 2)
                .offset(x: -3, y: 0)

            Capsule()
                .fill(Color.white.opacity(0.25))
                .frame(width: 8, height: 1.5)
                .offset(x: -5, y: 3)
        }
    }
}
