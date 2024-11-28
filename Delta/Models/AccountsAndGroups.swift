//
//  AccountsAndGroups.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import SwiftUI

class AccountsAndGroups: Identifiable, Hashable, Transferable, Codable {
    var id: UUID = UUID()
    var title: String = ""
    var currency: Currency = .usd
    var categoryType: CategoryType = .account
    var image: String = ""
    var color: String = ""
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        categoryType: CategoryType,
        image: String,
        color: String
    ) {
        self.id = id
        self.title = title
        self.currency = currency
        self.categoryType = categoryType
        self.image = image
        self.color = color
    }
}

extension AccountsAndGroups {
    // Добавляем метод для кодирования
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(currency, forKey: .currency)
        try container.encode(categoryType, forKey: .categoryType)
        try container.encode(image, forKey: .image)
        try container.encode(color, forKey: .color)
    }
    
    // CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id, title, currency, categoryType, image, color
    }
    
    static func == (lhs: AccountsAndGroups, rhs: AccountsAndGroups) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation<AccountsAndGroups, JSONEncoder, JSONDecoder>(contentType: .accountsAndGroups)
    }
}
