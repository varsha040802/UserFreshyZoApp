//
//  ProductCardView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 04/03/26.
//

import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    @EnvironmentObject var cartVM: CartViewModel
    var quantity: Int {
        cartVM.items.first(where: { $0.id == product.id })?.quantity ?? 0
    }
    
    var body: some View {
        let isPad =  UIDevice.current.userInterfaceIdiom == .pad
        
        HStack(spacing: isPad ? 20 : 14) {
            
            AsyncImage(url: product.imageURL){
                image in image
                    .resizable()
                    .scaledToFill()
                }placeholder: {
                    ProgressView()
                }
                .frame(width: isPad ? 130 : 95,
                       height: isPad ? 130 : 95)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(product.categoryName)
                    .font(.system(size: isPad ? 20 : 15, weight: .semibold))
                    .foregroundColor(Color("AppGreenColor"))
                
                Text("FreshyZo \(product.cleanName.replacingOccurrences(of: "\n", with: ""))")
                    .font(.system(size: isPad ? 18 : 15, weight: .semibold))
                
                Text(product.shortDesc)
                    .font(.system(size: isPad ? 16 : 13))
                    .foregroundColor(.gray)
                
                if !product.quantityText.isEmpty {
                    
                    Text(product.quantityText)
                        .font(.system(size: isPad ? 13 : 11, weight: .semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color("AppGreenColor").opacity(0.15))
                        .foregroundColor(Color("AppGreenColor"))
                        .cornerRadius(6)
                }

                
                HStack(spacing: 6) {
                    
                    Text("₹\(product.price)")
                        .font(.system(size: isPad ? 18 : 15, weight: .bold))
                    
                    Text("₹\(product.mrp)")
                        .font(.system(size: isPad ? 14 : 10))
                        .foregroundColor(.gray)
                        .strikethrough()
                    
                    if let price = Double(product.price),
                       let mrp = Double(product.mrp){
                        
                        let discount = Int(((mrp-price) / mrp) * 100)
                        Text("\(discount)% OFF")
                            .font(.system(size: isPad ? 15 : 10))
                            .lineLimit(1)
                            .fixedSize()
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(6)
                    }
                }
                
                HStack( spacing: 8) {
                    
//                    Button("Buy Once") {}
//                        .font(.system(size: isPad ? 16 : 12))
//                        .frame(maxWidth: .infinity)
//                        .foregroundColor(Color("AppGreenColor"))
//                        .frame(height: isPad ? 40 : 30)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color("AppGreenColor"))
//                        )
                    
                    if quantity == 0 {

                        Button("Buy Once") {
                            cartVM.addItem(
                                id: product.id,
                                name: product.cleanName,
                                price: Int(product.price) ?? 0
                            )
                        }
                        .font(.system(size: isPad ? 16 : 12))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("AppGreenColor"))
                        .frame(height: isPad ? 40 : 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AppGreenColor"))
                        )

                    } else {

                        HStack {

                                Spacer()

                                Button {
                                    cartVM.removeItem(id: product.id)
                                } label: {
                                    Text("-")
                                        .font(.system(size: isPad ? 18 : 14, weight: .bold))
                                        .foregroundColor(Color("AppGreenColor"))
                                }

                                Spacer()

                                Text("\(quantity)")
                                .font(.system(size: isPad ? 16 : 12, weight: .regular))
                                .foregroundColor(.black)

                                Spacer()

                                Button {
                                    cartVM.addItem(
                                        id: product.id,
                                        name: product.cleanName,
                                        price: Int(product.price) ?? 0
                                    )
                                } label: {
                                    Text("+")
                                        .font(.system(size: isPad ? 18 : 14, weight: .bold))
                                        .foregroundColor(Color("AppGreenColor"))
                                }

                                Spacer()
                        }
//                        .font(.system(size: isPad ? 16 : 12))
                        .frame(maxWidth: .infinity)
                        .frame(height: isPad ? 40 : 30)
                        .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("AppGreenColor").opacity(0.1))
                            )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AppGreenColor") , lineWidth: 2)
                        )
                    }
                    
                    Button("Subscribe") {}
                        .font(.system(size: isPad ? 16 : 12))
                        .frame(maxWidth: .infinity)
                        .frame(height: isPad ? 40 : 30)
                        .background(Color("AppGreenColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
        )
//        .frame(maxWidth: isPad ? 800 : .infinity)
        .frame(maxWidth: .infinity, alignment: .leading)

        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
    }
}


