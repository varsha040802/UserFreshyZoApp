//
//  header.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 25/03/26.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("My Wallet")
               .font(.title2.bold())
               .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HeaderView()
}
