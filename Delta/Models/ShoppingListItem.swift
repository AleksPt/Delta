//
//  ShoppingListItem.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 28.11.24.
//

import Foundation

@Observable
final class ShoppingListItem: Hashable, Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }
}

extension ShoppingListItem {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isCompleted, forKey: .isCompleted)
    }
    
    static func == (lhs: ShoppingListItem, rhs: ShoppingListItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Define coding keys to match property names
    private enum CodingKeys: String, CodingKey {
        case id, name, isCompleted
    }
}
