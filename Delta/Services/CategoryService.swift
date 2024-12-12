//
//  Category.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 10/4/24.
//

import SwiftUI

@Observable
final class CategoryService {
    var incomes: [Income] = DataStore.shared.incomes
    var expenses: [Expense] = DataStore.shared.expenses
    var subCategories: [SubCategory] = []
    var accounts: [Account] = DataStore.shared.accounts
    var groupsOfAccounts: [GroupOfAccounts] = DataStore.shared.groupsOfAccounts
    
    var accountsAndGroups: [AccountsAndGroups] = []
    
    var tags: [Tag] = DataStore.shared.tags
    
    init() {
        getAccountsAndGroups()
    }
    
//MARK: - INCOMES
    func createIncome(_ draftIncome: Income) {
        incomes.append(draftIncome)
    }
    
    func getSubIncomes() -> [SubCategory] {
        subCategories.filter { $0.categoryType == .income }
    }
    
    func removeIncome(at index: Int) {
        guard index >= 0 && index < incomes.count else { return }
        incomes.remove(at: index)
    }
    
    func createSubIncome() {
        let newSubCategory = SubCategory(
            id: UUID(),
            title: "",
            currency: .usd,
            categoryType: .income,
            amount: 5000,
            date: Date(),
            notification: false,
            autoTransaction: true,
            transaction: nil
        )
        
        subCategories.append(newSubCategory)
    }
    
    func isIncomeExist(_ id: UUID) -> Bool {
        incomes.contains { $0.id == id }
    }
    
//MARK: - EXPENSES
    func createExpense(_ draftExpense: Expense) {
        expenses.append(draftExpense)
    }
    
    func getSubExpenses() -> [SubCategory] {
        subCategories.filter { $0.categoryType == .expense }
    }
    
    func removeExpense(at index: Int) {
        guard index >= 0 && index < expenses.count else { return }
        expenses.remove(at: index)
    }
    
    func createSubExpense() {
        let newSubCategory = SubCategory(
            id: UUID(),
            title: "",
            currency: .usd,
            categoryType: .expense,
            amount: 5000,
            date: Date(),
            notification: false,
            autoTransaction: true,
            transaction: nil
        )
        
        subCategories.append(newSubCategory)
    }
    
    func isExpenseExist(_ id: UUID) -> Bool {
        expenses.contains { $0.id == id }
    }
    
    func getShoppingExpenses() -> [Expense] {
        expenses.filter { $0.isShoppingList == true }
    }
    
//MARK: - SUBCATEGORIES
    func removeSubCategory(at index: Int) {
        guard index >= 0 && index < subCategories.count else { return }
        subCategories.remove(at: index)
    }
    
//MARK: - ACCOUNTS
    func createAccount(_ account: Account) {
        accounts.append(account)
    }
    
    func removeAccount(by id: UUID) {
        if let index = accounts.firstIndex(where: { $0.id == id }) {
            accounts.remove(at: index)
        }
    }
    
    func isAccountExist(_ id: UUID) -> Bool {
        accounts.contains { $0.id == id }
    }
    
//MARK: - GROUP OF ACCOUNTS
    func createGroupOfAccounts(_ group: GroupOfAccounts) {
        groupsOfAccounts.append(group)
    }
    
    func removeGroupOfAccounts(by id: UUID) {
        if let index = groupsOfAccounts.firstIndex(where: { $0.id == id }) {
            groupsOfAccounts.remove(at: index)
        }
    }
    
    func getGroupOfAccounts(from title: String) -> GroupOfAccounts? {
        groupsOfAccounts.first { $0.title == title }
    }
    
    func isGroupOfAccountsExist(_ id: UUID) -> Bool {
        groupsOfAccounts.contains { $0.id == id }
    }
    
    func insertAccountToGroup(_ sourceAccounts: [DragDropItem], destinationAccount: Account) -> Bool {
        let item = sourceAccounts.first!
        guard let droppedItem = item.accountAndGroups else {
            return false
        }
        
        // Get Source and Destination UUIDs
        let droppedItemUUID = droppedItem.id
        let destinationAccountUUID = destinationAccount.id
        
        // Check if the UUIDs are the same
        if droppedItemUUID == destinationAccountUUID {
            return false
        }
        
        // Check if the source is a group
        if groupsOfAccounts.contains(where: { $0.id == droppedItemUUID }) {
            return false
        }
        
        // Remove an Account from a groupsOfAccounts or accountsAndGroups
        for group in groupsOfAccounts {
            if group.accounts.contains(where: { $0.id == droppedItemUUID }) {
                group.accounts.removeAll(where: { $0.id == droppedItemUUID })
            } else {
                accountsAndGroups.removeAll(where: { $0.id == droppedItemUUID })
            }
        }
    
        // Add Account in a groupsOfAccounts or accountsAndGroups
        guard let account = accounts.first(where: { $0.id == droppedItemUUID }) else {
            return false
        }
        
        for group in groupsOfAccounts {
            if group.accounts.contains(where: { $0.id == destinationAccountUUID}) {
                guard let destinationIndex = group.accounts.firstIndex(of: destinationAccount) else {
                    return false
                }
                group.accounts.insert(account, at: destinationIndex)
            }
        }
        
        return true
    }
    
    func updateGroups() {
        groupsOfAccounts.forEach { group in
            group.accounts.removeAll()
            
            accounts.forEach { account in
                if account.groupOfAccounts == group.title {
                    group.accounts.append(account)
                }
            }
        }
    }
    
//MARK: - ACCOUNTS AND GROUPS
    func getAccountsAndGroups() {
        accountsAndGroups = groupsOfAccounts + accounts.filter { $0.groupOfAccounts == "No group" }
    }
    
//MARK: - TAGS
    func getFilteredTags(text: String) -> [Tag] {
        if text.isEmpty {
            return []
        } else {
            return tags.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
    }

    func saveTags(text: String) {
        withAnimation {
            tags.forEach { tag in
                if !tag.name.contains(text) {
                    let newTag = Tag(name: text)
                    tags.append(newTag)
                }
            }
        }
    }
    
//MARK: - SHOPPING LIST CATEGORY
    func getCompletedItems() -> [ShoppingListItem] {
        expenses.flatMap { $0.items.filter { $0.isCompleted } }
    }
    
    func getCategoriesWithCompletedItems() -> [Expense] {
        expenses.filter { category in
            category.items.contains(where: { $0.isCompleted })
        }
    }
    
    func addItem(for category: Expense, text: String) {
        let newItem = ShoppingListItem(name: text)
        withAnimation {
            category.items.append(newItem)
        }
    }
    
    func deleteItems(at indexSet: IndexSet, from category: Expense) {
        if let categoryIndex = expenses.firstIndex(where: { $0.id == category.id }) {
            let activeItems = category.activeItems
            let itemsToDelete = indexSet.map { activeItems[$0].id }
            expenses[categoryIndex].items.removeAll { item in
                itemsToDelete.contains(item.id)
            }
        }
    }
    
    
    func addCategory(withName name: String) {
        let newCategory = Expense(
            amount: 0,
            image: "",
            repeatingType: .random,
            subCategories: [],
            transactions: [],
            id: UUID(),
            title: name,
            currency: .usd,
            categoryType: .expense,
            items: [],
            isShoppingList: true
        )
        expenses.append(newCategory)
    }
    
    func createShoppingTransactions(for account: Account?) -> [Transaction] {
        guard let account = account else { return [] }
        
        var transactions: [Transaction] = []
        
        for category in getCategoriesWithCompletedItems() {
            let transaction: Transaction = Transaction(
                id: UUID(),
                amount: category.amount,
                date: Date(),
                sourceID: category.id, // TODO: - Устанавливаем категорию как источник
                destinationID: account.id,
                tags: category.completedItems.map { $0.name },
                currency: account.currency,
                person: nil, // TODO: - Задать пользователя
                autoTransaction: nil
            )
            
            transactions.append(transaction)
        }
        
        return transactions
    }
    
    func deleteCompletedItems() {
        for expense in expenses {
            if !expense.items.isEmpty {
                expense.items.removeAll { $0.isCompleted == true}
                expense.amount = 0
            }
        }
    }
    
    func saveTransactions(_ transactions: [Transaction]) {
        for transaction in transactions {
            print("Сохранение транзакции на сумму \(transaction.amount) для категории \(transaction.sourceID)")
        }
        
        deleteCompletedItems()
    }
    
    // TODO: - доделать метод сохранения в базу
    
    // TODO: - добавить функционал
    //    func moveItem(in category: ShoppingListCategory, from source: IndexSet, to destination: Int) {
    //        var activeItems = category.activeItems
    //        activeItems.move(fromOffsets: source, toOffset: destination)
    //    }
    
    // TODO: - добавить сохранение по индексу в базу
}



