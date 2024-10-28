//
//  Routing.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 8/29/24.
//

import SwiftUI

enum Route: Hashable {
    case onboarding
    case login
    case main
    case profileSettings
    case appDesignSettings
    case accountSettings(account: Account)
    case accountGroupSettings(group: GroupOfAccounts)
    case seeAll
    case transfer
    case incomes
    case incomeSettings
    case expenseSettings
    case expenseCreate(expense: Expense)
}

enum TabRoute: Hashable {
    case main
    case analytic
    case shoppingList
    case settings
}

@MainActor
@Observable
final class Router {
    var startScreen: Route = .main
    var path = NavigationPath()
    
    @ViewBuilder func tabView() -> some View {
        TabBarView()
    }
        
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .onboarding:
            OnboardingView()
                .navigationBarBackButtonHidden()
        case .login:
            LoginView()
                .navigationBarBackButtonHidden()
        case .main:
            tabView()
        case .profileSettings:
            ProfileSettingsView()
                .navigationBarBackButtonHidden()
        case .appDesignSettings:
            AppDesignSettingsView()
                .navigationBarBackButtonHidden()
        case .accountSettings(let account):
            AccountSettingsView(account: account)
        case .accountGroupSettings(let group):
            AccountGroupSettingsView(groupOfAccounts: group)
        case .seeAll:
            SeeAllView()
                .navigationBarBackButtonHidden()
        case .transfer:
            TransferView()
                .navigationBarBackButtonHidden()
        case .incomes:
            IncomesView()
        case .incomeSettings:
            IncomeSettingsView()
        case .expenseSettings:
            ExpenseSettingsView()
        case .expenseCreate(let expense):
            ExpenseSettingsView(expense: expense)
        }
    }
    
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
        
    func navigateBack() {
        path.removeLast()
    }
        
    func popToRoot() {
        path.removeLast(path.count)
    }
}
