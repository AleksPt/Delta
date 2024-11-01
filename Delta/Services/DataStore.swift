//
//  DataStore.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import Foundation
import UISystem

final class DataStore {
    static let shared = DataStore()
    
    var people: [Person] = []
    //var categories: [Category] = []
    var transactions: [Transaction] = []
    var groupsOfAccounts: [GroupOfAccounts] = []
    var accounts: [Account] = []
    var incomes: [Income] = []
    var expenses: [Expense] = []
    var tags: [Tag] = []
    
    private init() {
        initializeTestData()
    }
    
    private func initializeTestData() {
        
        let alfabank = Account(
            id: UUID(),
            title: "Alfa bank",
            currency: .rub,
            image: Icon.creditcard.name,
            color: AppGradient.redGradient.name,
            users: [],
            transactions: [],
            categoryType: .account,
            groupOfAccounts: "Main"
        )
        
        let cash = Account(
            id: UUID(),
            title: "Cash",
            currency: .rub,
            image: Icon.dollar.name,
            color: AppGradient.blueGradient.name,
            users: [],
            transactions: [],
            categoryType: .account,
            groupOfAccounts: "Main"
        )
        
        let basic = Account(
            id: UUID(),
            title: "Basic",
            currency: .rub,
            image: Icon.dollar.name,
            color: AppGradient.appBlack.name,
            users: [],
            transactions: [],
            categoryType: .account,
            groupOfAccounts: "Sber bank"
        )
        
        let currency = Account(
            id: UUID(),
            title: "Currency",
            currency: .usd,
            image: Icon.dollar.name,
            color: AppGradient.purpleGradient.name,
            users: [],
            transactions: [],
            categoryType: .account,
            groupOfAccounts: "Sber bank"
        )
        
        let person1 = Person(
            id: UUID(),
            photo: "person1",
            name: "Tim",
            age: 30
        )
        
        let person2 = Person(
            id: UUID(),
            photo: "person2",
            name: "Bob",
            age: 25
        )

        alfabank.users = [person1]
        cash.users = [person2]
        basic.users = [person1]
        currency.users = [person1]
        
        let group1 = GroupOfAccounts(
            id: UUID(),
            title: "Sber bank",
            currency: .rub,
            image: "building.columns",
            color: AppGradient.appGreen.name,
            accounts: [basic, currency],
            categoryType: .groupOfAccounts
        )
        
        let group2 = GroupOfAccounts(
            id: UUID(),
            title: "Main",
            currency: .usd,
            image: "building.columns",
            color: AppGradient.blueGradient.name,
            accounts: [cash, alfabank],
            categoryType: .groupOfAccounts
        )
        
        people.append(person1)
        people.append(person2)
//        categories.append(alfabank)
//        categories.append(group1)
//        categories.append(cash)
//        categories.append(basic)
//        categories.append(currency)
        groupsOfAccounts.append(group1)
        groupsOfAccounts.append(group2)
        accounts.append(alfabank)
        accounts.append(cash)
        accounts.append(basic)
        accounts.append(currency)
        
        let taxi = Expense(
            amount: 200,
            image: "creditcard",
            repeatingType: .certain,
            subCategories: [],
            transactions: [],
            id: UUID(),
            title: "Taxi",
            currency: .rub,
            categoryType: .expense
        )
        
        let award = Income(
            amount: 20000,
            image: "trophy",
            repeatingType: .random,
            subCategories: [],
            transactions: [],
            id: UUID(),
            title: "Award",
            currency: .usd,
            categoryType: .income
        )
        
        let salary = Income(
            amount: 0,
            image: "handbag",
            repeatingType: .certain,
            subCategories: [SubCategory(
                id: UUID(),
                title: "Avance",
                currency: .rub,
                categoryType: .income,
                amount: 2000,
                date: Date(),
                notification: false,
                autoTransaction:  false,
                transaction: nil
            )],
            transactions: [],
            id: UUID(),
            title: "Salary",
            currency: .rub,
            categoryType: .income
        )
        
        incomes.append(award)
        incomes.append(salary)
        expenses.append(taxi)
        
        let food = Tag(name: "Food")
        let farmacy = Tag(name: "Farmacy")
        let clothes = Tag(name: "Clothes")
        let pets = Tag(name: "Pets")
        let hobbies = Tag(name: "Hobbies")
        
        tags.append(food)
        tags.append(farmacy)
        tags.append(clothes)
        tags.append(pets)
        tags.append(hobbies)
        
//        categories.append(award)
//        categories.append(salary)
//        categories.append(taxi)
        
    }
}
