//
//  Expense.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import SwiftUI

@Observable
final class Expense: Identifiable, Hashable, Transferable, Codable {
    var id: UUID = UUID()
    var title: String = ""
    var currency: Currency = .usd
    var categoryType: CategoryType = .expense
    var amount: Double
    var image: String = ""
    var repeatingType: RepeatingType = .random
    var subCategories: [SubCategory] = []
    var transactions: [Transaction] = []
    var items: [ShoppingListItem] = []
    var isShoppingList: Bool = false
    
    var plannedAmount: Double {
        subCategories.reduce(0) { $0 + $1.amount }
    }
    
    // проверить обнуления amount при начале нового периода
    var totalAmount: Double {
        let filteredTransactions = DataManager.filterTransactions(transactions, for: .month, startDay: 1, fromMonthOffset: 0)
        return filteredTransactions.reduce(0) { $0 + $1.amount }
    }
    
    var isExceeded: Bool {
        amount >= plannedAmount
    }
    
    var amountsAndDates: [(amount: Double, date: Date)] {
        repeatingType == .random ? getAmountsByDate() : getAmountsByPeriod()
    }
    
    var activeItems: [ShoppingListItem] {
        items.filter { !$0.isCompleted }
    }
    
    var completedItems: [ShoppingListItem] {
        items.filter { $0.isCompleted }
    }
    
    init(
        amount: Double,
        image: String,
        repeatingType: RepeatingType,
        subCategories: [SubCategory],
        transactions: [Transaction],
        id: UUID,
        title: String,
        currency: Currency,
        categoryType: CategoryType,
        items: [ShoppingListItem],
        isShoppingList: Bool
    ) {
        self.id = id
        self.title = title
        self.currency = currency
        self.categoryType = categoryType
        self.amount = amount
        self.image = image
        self.repeatingType = repeatingType
        self.subCategories = subCategories
        self.transactions = transactions
        self.items = items
        self.isShoppingList = isShoppingList
    }
    
    // Добавляем required init для декодирования
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.currency = try container.decode(Currency.self, forKey: .currency)
        self.categoryType = try container.decode(CategoryType.self, forKey: .categoryType)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.image = try container.decode(String.self, forKey: .image)
        self.repeatingType = try container.decode(RepeatingType.self, forKey: .repeatingType)
        self.subCategories = try container.decode([SubCategory].self, forKey: .subCategories)
        self.transactions = try container.decode([Transaction].self, forKey: .transactions)
        self.items = try container.decode([ShoppingListItem].self, forKey: .items)
        self.isShoppingList = try container.decode(Bool.self, forKey: .isShoppingList)
    }
    
    // методы для построения графика "План"
    func getAmountsByPeriod() -> [(amount: Double, date: Date)] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        let numberOfDaysInMonth = range.count
        
        let dailyAmount = plannedAmount / Double(numberOfDaysInMonth)
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        
        var result: [(amount: Double, date: Date)] = []
        for day in 0..<numberOfDaysInMonth {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth) {
                result.append((amount: dailyAmount, date: date))
            }
        }
        return result
    }
    
    func getAmountsByDate() -> [(amount: Double, date: Date)] {
        return subCategories.map { ($0.amount, $0.date) }
    }
}

extension Expense {
    // Добавляем метод для кодирования
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(currency, forKey: .currency)
        try container.encode(categoryType, forKey: .categoryType)
        try container.encode(amount, forKey: .amount)
        try container.encode(image, forKey: .image)
        try container.encode(repeatingType, forKey: .repeatingType)
        try container.encode(subCategories, forKey: .subCategories)
        try container.encode(transactions, forKey: .transactions)
        try container.encode(items, forKey: .items)
        try container.encode(isShoppingList, forKey: .isShoppingList)
    }
    
    // CodingKeys
    private enum CodingKeys: String, CodingKey {
            case id, title, currency, categoryType, amount, image, repeatingType, subCategories, transactions, items, isShoppingList
        }
    
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation<Expense, JSONEncoder, JSONDecoder>(contentType: .expense)
    }
}
