//
//  historySection.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 25/03/26.
//

import SwiftUI

struct historySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Text("Recharge History")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("View all")
                        .foregroundColor(.green)
                }
                
                VStack(spacing: 10) {
                    Image(systemName: "doc.text")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    
                    Text("No transactions yet")
                        .font(.headline)
                    
                    Text("Your recharge history will appear here")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
    }
}

#Preview {
    historySection()
}
