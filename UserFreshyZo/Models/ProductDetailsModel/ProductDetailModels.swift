//
//  FAQItem.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 30/03/26.
//

import Foundation

// MARK: - FAQ Model
struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}
