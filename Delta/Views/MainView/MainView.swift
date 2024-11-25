//
//  MainView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 08.07.24.
//

import SwiftUI
import UISystem

struct MainView: View {
    @Environment(CategoryService.self) private var categoryService
    
    let categoryTypes = CategoryType.getCategoryTypes()

    @State private var accounts: [Account] = []
    @State private var groups: [GroupOfAccounts] = []
    @State private var activeTab = CategoryType.expense
    
    var body: some View {
        VStack {
            InfoMainView()
            Spacer()
            
            AccountsAndGroupsScrollView()
                .safeAreaPadding(.horizontal)
            Spacer()
            
            ButtonsScrollView(
                categoryTypes: categoryTypes,
                activeTab: $activeTab
            )
                .safeAreaPadding(.horizontal)
            Spacer()
            
            switch activeTab {
            case .expense:
                ExpenseScrollView(
                    expenses: categoryService.expenses,
                    title: "Expenses",
                    settingsRoute: .expenseCreate,
                    categoryRoute: .incomes
                )
            case .account:
                EmptyView()
            case .groupOfAccounts:
                EmptyView()
            case .income:
                IncomeScrollView(
                    incomes: categoryService.incomes,
                    title: "Incomes",
                    settingsRoute: .incomeCreate,
                    categoryRoute: .incomes
                )
            }
            
//            if activeTab == .income {
//                IncomeScrollView(categories: categoryService.getCategories(with: .income))
//                    .safeAreaPadding(.horizontal)
//                
//                ForEach(categoryTypes, id: \.self) { category in
//                    if category == activeTab {
//                        HeaderMainView(text: category.rawValue, action: {})
//                        CategoriesScrollView(categories: categoryService.getCategories(with: category))
//                            .frame(height: Constants.heightTwo)
//                            .safeAreaPadding(.horizontal)
//                    }
//                }
//            }
        }
        .padding(.vertical)
        .background(AppGradient.appBackground.value)
        .onAppear {
            accounts = categoryService.accounts
            groups = categoryService.groupsOfAccounts
        }
    }
}

#Preview {
    MainView()
        .environment(CategoryService())
        .environment(Router.shared)
}
