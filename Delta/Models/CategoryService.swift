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
        accountsAndGroups = groupsOfAccounts + accounts.filter { $0.groupOfAccounts == "" }
    }
    
}


