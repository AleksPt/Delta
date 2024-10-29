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
    
    private var dataManager = DataManager.shared // @StateObject
    let categoryTypes = CategoryType.getCategoryTypes()

    @State private var accounts: [Category] = []
    @State private var activeTab = CategoryType.expense
    
    init() {
        _ = DataManager.shared
    }
    
    var body: some View {
        VStack {
            InfoMainView()
            Spacer()
            
            AccountsAndGroupsScrollView(categories: accounts)
                .safeAreaPadding(.horizontal)
            Spacer()
            
            ButtonsScrollView(categoryTypes: categoryTypes, activeTab: $activeTab)
                .safeAreaPadding(.horizontal)
            Spacer()
            
            switch activeTab {
            case .expense:
                CategoriesScrollView(categories: categoryService.getCategories(with: .expense), title: "Expenses", settingsRoute: .expenseCreate, categoryRoute: .incomes)
            case .account:
                EmptyView()
            case .groupOfAccounts:
                EmptyView()
            case .income:
                CategoriesScrollView(categories: categoryService.getCategories(with: .income), title: "Incomes", settingsRoute: .incomeCreate, categoryRoute: .incomes)
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
            accounts = dataManager.getAccountsAndGroup()
            
        }
    }
}

#Preview {
    MainView()
        .environment(CategoryService())
        .environment(Router.shared)
}
