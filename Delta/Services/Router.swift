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
    case accountCreate
    case accountGroupCreate
    case seeAll
    case incomes
    case incomeSettings(income: Income)
    case expenseSettings(expense: Expense)
    case incomeCreate
    case expenseCreate
    case transfer(sourse: Account, destination: Account)
}

enum TabRoute: Hashable {
    case main
    case analytic
    case shoppingList
    case settings
}

enum ModalRoute: Equatable {
    static func == (lhs: ModalRoute, rhs: ModalRoute) -> Bool {
        switch (lhs, rhs) {
        case (.seeAllAccounts(let lhsAccounts), .seeAllAccounts(let rhsAccounts)):
            lhsAccounts.wrappedValue == rhsAccounts.wrappedValue
        case (.seeAll, .seeAll):
            true
        case (.tags(let lhsTags), .tags(let rhsTags)):
            lhsTags.wrappedValue == rhsTags.wrappedValue
        default:
            false
        }
    }
    
    case seeAllAccounts(accounts: Binding<[Account]>)
    case seeAll
    
    case tags(tags: Binding<[Tag]>)
}

@MainActor
@Observable
final class Router {

    static let shared = Router()
    
    var startScreen: Route = .main
    var path = NavigationPath()
    
    var modalRoute: ModalRoute? = nil
    var isModalPresented: Bool = false
    
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
        case .incomes:
            IncomesView()
        case .incomeSettings(let income):
            IncomeSettingsView(income: income)
        case .expenseSettings(let expense):
            ExpenseSettingsView(expense: expense)
        case .accountCreate:
            AccountSettingsView()
        case .accountGroupCreate:
            AccountGroupSettingsView()
        case .incomeCreate:
            IncomeSettingsView()
        case .expenseCreate:
            ExpenseSettingsView()
        case .transfer(let source, let destination):
            TransferView(fromAccount: source, toAccount: destination)
        }
    }
    
    @ViewBuilder func modalView(for modalRoute: ModalRoute) -> some View {
        switch modalRoute {
        case .seeAllAccounts(let accounts):
            SeeAllAccounts(accounts: accounts)
        case .seeAll:
            SeeAllView()
        case .tags(let tags):
            TagsView(selectedTags: tags)
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
    
    func presentModal(_ appRoute: ModalRoute) {
        modalRoute = appRoute
        isModalPresented = true
    }
    
    func dismissModal() {
        isModalPresented = false
    }
    
    private init() {}
}
