//
//  Transaction.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import Foundation

final class Transaction: Codable {
    var id: UUID = UUID()
    var amount: Double = 0.0
    var date: Date = Date()
    var sourceID: UUID = UUID()
    var destinationID: UUID = UUID()
    var tags: [String] = []
    var currency: Currency = .rub
    var person: Person?
    var autoTransaction: AutoTransaction?
    
    private enum CodingKeys: String, CodingKey {
        case id, amount, date, sourceID, destinationID, tags, currency, person
    }
    
    init(
        id: UUID,
        amount: Double,
        date: Date,
        sourceID: UUID,
        destinationID: UUID,
        tags: [String],
        currency: Currency,
        person: Person?,
        autoTransaction: AutoTransaction?
    ) {
        self.id = id
        self.amount = amount
        self.date = date
        self.sourceID = sourceID
        self.destinationID = destinationID
        self.tags = tags
        self.currency = currency
        self.person = person
        self.autoTransaction = autoTransaction
    }
}
