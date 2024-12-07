//
//  CategoryType.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

enum CategoryType: String, CaseIterable, Codable {
    case account = "Account"
    case groupOfAccounts = "GroupOfAccounts"
    case income = "Income"
    case expense = "Expense"
    //    case goal = "Goal"
    //    case loan = "Loan"
    //    case credit = "Credit"
    //    case investment = "Investment"
    
    static func getCategoryTypes() -> [CategoryType] {
        CategoryType.allCases
            .filter { $0 != .account && $0 != .groupOfAccounts }
            .map { $0 }
    }
}
