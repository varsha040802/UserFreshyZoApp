//
//  MilkTrialView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 26/03/26.
//

import SwiftUI

struct MilkTrialView: View {

    // ── Data passed from the banner tap ──────────────────────────────────
    let banner: Banner

    // ── Local state ──────────────────────────────────────────────────────
    @State private var selectedProduct: TrialProduct
    @State private var selectedDate: Date?
    @State private var showDatePicker = false
    @Environment(\.dismiss) private var dismiss

    // Products to show in the picker
    private var products: [TrialProduct] {
        banner.trialProducts ?? HomeViewModel.defaultTrialProducts
    }

    // ── Init: pre-select first product ───────────────────────────────────
    init(banner: Banner) {
        self.banner = banner
        let list = banner.trialProducts ?? HomeViewModel.defaultTrialProducts
        _selectedProduct = State(initialValue: list[0])
    }

    // ── Date formatter ────────────────────────────────────────────────────
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }

    // ─────────────────────────────────────────────────────────────────────
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                // MARK: - Banner Image
                AsyncImage(url: URL(string: banner.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .clipped()

                // MARK: - Subscription Details Card
                VStack(alignment: .leading, spacing: 16) {

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Subscription Details")
                            .font(.title3).bold()
                        Text("Select product and start date to start your trial")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // ── Product Picker ────────────────────────────────────
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Select Product")
                            .font(.subheadline).bold()

                        Menu {
                            ForEach(products) { product in
                                Button {
                                    // ✅ Changing product updates price automatically
                                    selectedProduct = product
                                } label: {
                                    HStack {
                                        Text(product.name)
                                        if selectedProduct.id == product.id {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedProduct.name)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                        }
                    }

                    // ── Date Picker ───────────────────────────────────────
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Select Date")
                            .font(.subheadline).bold()

                        Button {
                            withAnimation { showDatePicker.toggle() }
                        } label: {
                            HStack {
                                Text(selectedDate != nil
                                     ? dateFormatter.string(from: selectedDate!)
                                     : "Select Date")
                                    .foregroundColor(selectedDate != nil ? .primary : .secondary)
                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                        }

                        if showDatePicker {
                            DatePicker(
                                "",
                                selection: Binding(
                                    get: { selectedDate ?? Date() },
                                    set: { selectedDate = $0; showDatePicker = false }
                                ),
                                in: Date()...,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.graphical)
                            .tint(Color(hex: "#2E7D32"))
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                .padding()

                // MARK: - Price Total Card ─────────────────────────────────
                // ✅ This entire card re-renders whenever selectedProduct changes
                VStack(alignment: .leading, spacing: 14) {

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Price Total")
                            .font(.title3).bold()
                        Text("Prices are calculated for total period of the offer.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Divider()

                    PriceRow(label: "Total MRP",
                             value: "₹\(Int(selectedProduct.mrp))",
                             color: .primary)

                    PriceRow(label: "Offer Discount",
                             value: "-₹\(Int(selectedProduct.discount))",
                             color: Color(hex: "#2E7D32"))

                    PriceRow(label: "Delivery Fee",
                             value: "₹0",
                             color: Color(hex: "#2E7D32"))

                    Divider()

                    PriceRow(label: "Total Payable",
                             value: "₹\(Int(selectedProduct.payable))",
                             color: .primary,
                             isBold: true)

                    Text("Charges are deducted post-delivery. Please ensure sufficient wallet balance.")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(.top, 4)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                .padding(.horizontal)

                Spacer(minLength: 100) // space for the CTA button
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Get Milk Trial")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            // MARK: - Start Trial Button
            Button {
                handleStartTrial()
            } label: {
                Text("Start Trial")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#2E7D32"))
                    .cornerRadius(14)
                    .padding()
            }
            .background(Color(.systemBackground))
        }
    }

    // ── Actions ───────────────────────────────────────────────────────────
    private func handleStartTrial() {
        guard selectedDate != nil else {
            // TODO: Show alert asking user to pick a date
            return
        }
        // TODO: Call your API / ViewModel to start trial
        // Parameters available:
        //   banner.id, banner.name
        //   selectedProduct.id, selectedProduct.name, selectedProduct.payable
        //   selectedDate
        print("Starting trial: product=\(selectedProduct.name), payable=₹\(Int(selectedProduct.payable)), date=\(String(describing: selectedDate))")
    }
}

// MARK: - Helper: Price Row
private struct PriceRow: View {
    let label: String
    let value: String
    var color: Color = .primary
    var isBold: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(isBold ? .subheadline.bold() : .subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(isBold ? .subheadline.bold() : .subheadline)
                .foregroundColor(color)
        }
    }
}

// MARK: - Helper: Hex Color
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8)  & 0xFF) / 255
            b = Double(int         & 0xFF) / 255
        default:
            r = 0; g = 0; b = 0
        }
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        MilkTrialView(banner: Banner(
            id: 1,
            name: "Top 10 Dairy Products",
            image: "https://static1.squarespace.com/static/638d8044b6fc77648ebcedba/t/67a5b74af834d07712692f36/1738913639066/Top+10+dairy+products+for+your+kitchen+-+Kota+Fresh+Dairy.png?format=1500w",
            price: 45,
            trialProducts: HomeViewModel.defaultTrialProducts
        ))
    }
}

#Preview {
    MilkTrialView()
}
