//
//  SubscriptionRequest.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 31/03/26.
//

import Foundation

// MARK: - Subscription Request (sent to API)

struct SubscriptionRequest: Codable {
    let productId:   String
    let productName: String
    let basePrice:   Int
    let frequency:   String
    let altDayOption: String?   // only for altDays
    let weeklyDays:  [WeeklyDayRequest]? // only for weekly
    let simpleQty:   Int?       // only for daily / altDays
    let startDate:   String
    let totalMonthly: Double
    let deliveriesPerMonth: Int
    let totalPackets: Int
}

struct WeeklyDayRequest: Codable {
    let day: String
    let qty: Int
}
