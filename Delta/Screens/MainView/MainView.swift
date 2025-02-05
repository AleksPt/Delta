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

    @State private var activeTab = CategoryType.expense
    @State private var expandedGroupID: UUID?
    @State private var accountsAndGroups: [AccountsAndGroups] = []
    
    var body: some View {
        VStack {
            InfoMainView()
            Spacer()
            
            AccountsAndGroupsScrollView(expandedGroupID: $expandedGroupID, accountsAndGroups: $accountsAndGroups)
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
        }
        .padding(.vertical)
        .background(AppGradient.appBackground.value)
        .onAppear {
            categoryService.getAccountsAndGroups()
            accountsAndGroups = categoryService.accountsAndGroups
        }
        .onTapGesture {
            withAnimation(.spring()) {
                expandedGroupID = nil
            }
        }
        
        .onChange(of: activeTab) {
            withAnimation(.spring()) {
                expandedGroupID = nil
            }
        }
    }
}

#Preview {
    MainView()
        .environment(CategoryService())
        .environment(Router.shared)
}
