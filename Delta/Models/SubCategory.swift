//
//  SubCategory.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import SwiftUI

@Observable
final class SubCategory: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var title: String = ""
    var currency: Currency = .usd
    var categoryType: CategoryType = .income
    var amount: Double = 0
    var date: Date
    var notification: Bool
    var autoTransaction: Bool
    var transaction: Transaction?
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        categoryType: CategoryType,
        amount: Double,
        date: Date,
        notification: Bool,
        autoTransaction: Bool,
        transaction: Transaction? = nil
    ) {
        self.id = id
        self.title = title
        self.currency = currency
        self.categoryType = categoryType
        self.amount = amount
        self.date = date
        self.notification = notification
        self.autoTransaction = autoTransaction
        self.transaction = transaction
    }
    
    // Добавляем required init(from:)
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.currency = try container.decode(Currency.self, forKey: .currency)
        self.categoryType = try container.decode(CategoryType.self, forKey: .categoryType)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.date = try container.decode(Date.self, forKey: .date)
        self.notification = try container.decode(Bool.self, forKey: .notification)
        self.autoTransaction = try container.decode(Bool.self, forKey: .autoTransaction)
        self.transaction = try container.decodeIfPresent(Transaction.self, forKey: .transaction)
    }
}

extension SubCategory {
    // Добавляем encode(to:)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(currency, forKey: .currency)
        try container.encode(categoryType, forKey: .categoryType)
        try container.encode(amount, forKey: .amount)
        try container.encode(date, forKey: .date)
        try container.encode(notification, forKey: .notification)
        try container.encode(autoTransaction, forKey: .autoTransaction)
        try container.encode(transaction, forKey: .transaction)
    }
    
    // Определяем CodingKeys для кодирования/декодирования
    private enum CodingKeys: String, CodingKey {
        case id, title, currency, categoryType, amount, date, notification, autoTransaction, transaction
    }
    
    static func == (lhs: SubCategory, rhs: SubCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
