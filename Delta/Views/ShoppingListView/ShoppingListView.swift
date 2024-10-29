//
//  ShoppingListView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI

final class Tag {
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
}

@Observable final class ShoppingListItem: Hashable, Identifiable{
    var id: UUID = UUID()
    var name: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
    }
    
    static func == (lhs: ShoppingListItem, rhs: ShoppingListItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Observable final class ShoppingListCategory: Hashable, Identifiable{
    var id: UUID = UUID()
    var name: String = ""
    var items: [ShoppingListItem] = []
    var amount: String = ""
    
    var activeItems: [ShoppingListItem] {
        items.filter { !$0.isCompleted }
    }
    
    var completedItems: [ShoppingListItem] {
        items.filter { $0.isCompleted }
    }
    
    init(id: UUID = UUID(), name: String, items: [ShoppingListItem] = [], amount: String = "") {
        self.id = id
        self.name = name
        self.items = items
        self.amount = amount
    }
    
    static func == (lhs: ShoppingListCategory, rhs: ShoppingListCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Observable final class ShoppingListModel {
    var categories = [
        ShoppingListCategory(
            name: "products",
            items: [
                ShoppingListItem(name: "Bread"),
                ShoppingListItem(name: "Tomato"),
                ShoppingListItem(name: "Pasta"),
                ShoppingListItem(name: "Water")
            ]
        ),
        ShoppingListCategory(
            name: "home",
            items: [ShoppingListItem(name: "Table")]
        ),
        ShoppingListCategory(
            name: "wear",
            items: [ShoppingListItem(name: "T-Shirt")]
        )
    ]
    
    let accountsAndGroups = DataManager.shared.getAccountsAndGroup()
    
    var completedItems: [ShoppingListItem] {
        categories.flatMap { $0.items.filter { $0.isCompleted } }
    }
    
    var categoriesWithCompletedItems: [ShoppingListCategory] {
        categories.filter { category in
            category.items.contains(where: { $0.isCompleted })
        }
    }
        
    func addItem(_ newItem: ShoppingListItem, for category: ShoppingListCategory) {
        category.items.append(newItem)
    }
    
    // TODO: - добавить функционал
    
//    func moveItem(in category: ShoppingListCategory, from source: IndexSet, to destination: Int) {
//        var activeItems = category.activeItems
//        activeItems.move(fromOffsets: source, toOffset: destination)
//    }

    func deleteItems(at indexSet: IndexSet, from category: ShoppingListCategory) {
        if let categoryIndex = categories.firstIndex(where: { $0.id == category.id }) {
            let activeItems = category.activeItems
            let itemsToDelete = indexSet.map { activeItems[$0].id }
            categories[categoryIndex].items.removeAll { item in
                itemsToDelete.contains(item.id)
            }
        }
    }
    
    // TODO: - добавить сохранение по индексу в базу
    
    func addCategory(withName name: String) {
        let newCategory = ShoppingListCategory(name: name, items: [])
        categories.append(newCategory)
    }
    
    func createTransactions(for account: Account?) -> [Transaction] {
        guard let account = account else { return [] }
        
        var transactions: [Transaction] = []
        
        for category in categoriesWithCompletedItems {
            
            let transaction = Transaction()
            transaction.amount = Double(category.amount) ?? 0
            transaction.date = Date()
            transaction.sourceID = category.id // TODO: - Устанавливаем категорию как источник
            transaction.destinationID = account.id
            transaction.tags = category.completedItems.map { $0.name }
            transaction.currency = account.currency
            transaction.person = nil // TODO: - Задать пользователя
            
            transactions.append(transaction)
        }
        
        return transactions
    }
    
    func deleteCompletedItems() {
        for category in categories {
            category.items.removeAll { $0.isCompleted == true}
            category.amount = ""
        }
    }
    
    // TODO: - доделать метод сохранения в базу
    
    func saveTransactions(_ transactions: [Transaction]) {
        for transaction in transactions {
            print("Сохранение транзакции на сумму \(transaction.amount) для категории \(transaction.sourceID)")
        }
        
        deleteCompletedItems()
    }
}

struct ShoppingListView: View {
    @State private var shoppingListModel = ShoppingListModel()
    @State private var categoryName = ""
    @State private var selectedAccount: Account? = nil
//    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach($shoppingListModel.categories) { $category in
                        Section {
                            ForEach(category.activeItems) { item in
                                ShoppingListItemView(item: item)
                            }
                            .onDelete { indexSet in
                                shoppingListModel.deleteItems(at: indexSet, from: category)
                            }
                            
                            ShoppingListAddView(category: category)
                        } header: {
                            Text(category.name)
                        }
                    }
//                    .focused($isInputActive)
                    
                    if !shoppingListModel.completedItems.isEmpty {
                        Section {
                            ForEach(shoppingListModel.completedItems) { item in
                                ShoppingListItemView(item: item)
                            }
                            ForEach(shoppingListModel.categoriesWithCompletedItems) { category in
                                ShoppingListAmountRowView(category: category)
                            }
                            
                            ShoppingListAccountsScrollView(
                                categories: shoppingListModel.accountsAndGroups,
                                selectedAccount: $selectedAccount
                            )
                            .listRowInsets(EdgeInsets())
                         
                            if selectedAccount != nil {
                                RoundedButtonView(title: "Buy", action: {
                                    let transactions = shoppingListModel.createTransactions(for: selectedAccount)
                                    shoppingListModel.saveTransactions(transactions)
                                    selectedAccount = nil
                                })
                                .id("BuySection")
                            }
                        } header: {
                            Text("Completed")
                        }
                    }
                }
                .listSectionSpacing(.compact)
                .navigationTitle("Shopping List")
                .toolbar {
                    Button(action: {
                        shoppingListModel.addCategory(withName: categoryName)
                    }) {
                        Image(systemName: "plus")
                    }
                }
                .foregroundStyle(.appBlack)
                .onChange(of: selectedAccount) { _ , newValue in
                    if newValue != nil {
                        withAnimation {
                            proxy.scrollTo("BuySection", anchor: .bottom)
                        }
                    }
                }
//                .onTapGesture {
//                    isInputActive = false
//                }
            }
        }
    }
}

#Preview {
    ShoppingListView()
}
