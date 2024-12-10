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
    case incomes
    case incomeSettings(income: Income)
    case expenseSettings(expense: Expense)
    case incomeCreate
    case expenseCreate
    case transfer(sourse: UUID, destination: Account)
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
        case (.tags(let lhsTags), .tags(let rhsTags)):
            lhsTags.wrappedValue == rhsTags.wrappedValue
        default:
            false
        }
    }
    
    case seeAllAccounts(accounts: Binding<[Account]>)
    
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
                .navigationBarBackButtonHidden()
        case .accountGroupSettings(let group):
            AccountGroupSettingsView(groupOfAccounts: group)
                .navigationBarBackButtonHidden()
        case .incomes:
            SeeAllIncomesView()
                .navigationBarBackButtonHidden()
        case .incomeSettings(let income):
            IncomeSettingsView(income: income)
                .navigationBarBackButtonHidden()
        case .expenseSettings(let expense):
            ExpenseSettingsView(expense: expense)
                .navigationBarBackButtonHidden()
        case .accountCreate:
            AccountSettingsView()
                .navigationBarBackButtonHidden()
        case .accountGroupCreate:
            AccountGroupSettingsView()
                .navigationBarBackButtonHidden()
        case .incomeCreate:
            IncomeSettingsView()
                .navigationBarBackButtonHidden()
        case .expenseCreate:
            ExpenseSettingsView()
                .navigationBarBackButtonHidden()
        case .transfer(let sourceID, let destination):
            TransferView(fromAccountID: sourceID, toAccount: destination)
                .navigationBarBackButtonHidden()
        }
    }
    
    @ViewBuilder func modalView(for modalRoute: ModalRoute) -> some View {
        switch modalRoute {
        case .seeAllAccounts(let accounts):
            SeeAllAccounts(accounts: accounts)
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

// MARK: - Public Methods for DragAndDrop
extension Router {
    func dropTransfer(items: [DragDropItem], destination: Account) -> Bool {
        let item = items.first!
        
        switch item {
        case .income(let income):
            
            // TODO: add link for income transfer
            
            navigateTo(.incomes)
            print(income.title)
            
            return true
            
        case .accountAndGroups(let accountsAndGroups):
            if accountsAndGroups.id == destination.id {
                return false
            } else {
                navigateTo(.transfer(sourse: accountsAndGroups.id, destination: destination))
                return true
            }
        }
    }
}
