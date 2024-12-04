//
//  Account.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import Foundation

final class Account: AccountsAndGroups {
    var users: [Person] = []
    var transactions: [Transaction] = []
    var groupOfAccounts: String = ""
    
    var incomingTransactions: [Transaction] {
        transactions.filter { $0.destinationID == self.id }
    }
    
    var outgoingTransactions: [Transaction] {
        transactions.filter { $0.sourceID == self.id }
    }
    
    var amount: Double {
        incomingTransactions.reduce(0) { $0 + $1.amount } - outgoingTransactions.reduce(0) { $0 + $1.amount }
    }
    // изменить balance можно добавив транзакцию (сервисную), в зависимости от знака либо в incomingAmount, либо в outgoingAmount
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        image: String,
        color: String,
        users: [Person],
        transactions: [Transaction],
        categoryType: CategoryType = .account,
        groupOfAccounts: String
    ) {
        self.users = users
        self.transactions = transactions
        self.groupOfAccounts = groupOfAccounts
        super.init(
            id: id,
            title: title,
            currency: currency,
            categoryType: categoryType,
            image: image,
            color: color
        )
    }
    
    // Добавляем required init для декодирования
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.users = try container.decode([Person].self, forKey: .users)
        self.transactions = try container.decode([Transaction].self, forKey: .transactions)
        try super.init(from: decoder)
    }
}

extension Account {
    // Добавляем метод для кодирования
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(title, forKey: .title)
//        try container.encode(currency, forKey: .currency)
//        try container.encode(categoryType, forKey: .categoryType)
//        try container.encode(image, forKey: .image)
//        try container.encode(color, forKey: .color)
//        try container.encode(users, forKey: .users)
//        try container.encode(transactions, forKey: .transactions)
//    }
    
    // CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id, title, currency, categoryType, image, color, users, transactions
    }
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}
