//
//  rechargeSection.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 25/03/26.
//

import SwiftUI

struct rechargeSection: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
               
               Text("Recharge Wallet")
                   .font(.headline)
               
               HStack {
                   Text("₹")
                   
                   TextField("Enter amount", text: $vm.rechargeAmount)
                       .keyboardType(.numberPad)
               }
               .padding()
               .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green))
               
               Button {
                   vm.recharge()
               } label: {
                   Text("Recharge")
                       .frame(maxWidth: .infinity)
                       .frame(height: 45)
                       .background(Color.green.opacity(0.6))
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
               
               couponBox
           }
    }
}

#Preview {
    rechargeSection()
}
