//
//  GroupOfAccounts.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import Foundation

final class GroupOfAccounts: AccountsAndGroups {
    var accounts: [Account] = []
    
    var totalAmount: Double {
        accounts.reduce(0) { $0 + $1.amount }
    }
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        image: String,
        color: String,
        accounts: [Account],
        categoryType: CategoryType = .groupOfAccounts
    ) {
        self.accounts = accounts
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
//        self.id = try container.decode(UUID.self, forKey: .id)
//        self.title = try container.decode(String.self, forKey: .title)
//        self.currency = try container.decode(Currency.self, forKey: .currency)
//        self.categoryType = try container.decode(CategoryType.self, forKey: .categoryType)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.color = try container.decode(String.self, forKey: .color)
        self.accounts = try container.decode([Account].self, forKey: .accounts)
        try super.init(from: decoder)
    }
}

extension GroupOfAccounts {
    // Добавляем метод для кодирования
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(title, forKey: .title)
//        try container.encode(currency, forKey: .currency)
//        try container.encode(categoryType, forKey: .categoryType)
//        try container.encode(image, forKey: .image)
//        try container.encode(color, forKey: .color)
//        try container.encode(accounts, forKey: .accounts)
//    }
    
    // CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id, title, currency, categoryType, image, color, accounts
    }
    
    static func == (lhs: GroupOfAccounts, rhs: GroupOfAccounts) -> Bool {
        return lhs.id == rhs.id
    }
}
