//
//  AccountsAndGroupsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 16.10.24.
//

import SwiftUI

struct AccountsAndGroupsScrollView: View {
    @Environment(CategoryService.self) private var categoryService
    @Environment(Router.self) private var router
    
    @State private var selectedGroup: GroupOfAccounts?
    @State private var isExpanded = false
    @State private var droppedItem: DragDropItem?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderMainView(text: "Accounts", action: {
                // TODO: - add See all
            })
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(categoryService.accountsAndGroups, id: \.id) { item in
                            if let account = item as? Account {
                                AccountCardView(
                                    account: account,
                                    size: CGSize(width: Constants.widthTwo, height: Constants.heightThree)
                                )
                                .draggable(account)

                                .dropDestination(for: DragDropItem.self) { droppedItems, location in
                                    return dropTransfer(items: droppedItems, destination: account)
                                }
                                
                            } else if let group = item as? GroupOfAccounts {
                                AccountGroupCardView(accountsGroup: group, onSelect: {
                                    selectedGroup = nil
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        selectedGroup = group
                                    }
                                })
                                .onChange(of: selectedGroup) { _, newValue in
                                    if let selectedGroup = newValue {
                                        withAnimation {
                                            proxy.scrollTo(selectedGroup.id, anchor: .leading)
                                        }
                                    }
                                }
                            }
                        }
                    
                        PlusButtonView {
                            router.navigateTo(.accountCreate)
                        }
                        .frame(width: Constants.widthOne)
                    }
                }
            }
            .shadow()
        }
        .onAppear {
            categoryService.getAccountsAndGroups()
        }
    }
    
    private func dropTransfer(items: [DragDropItem], destination: Account) -> Bool {
        let item = items.first!
        
        switch item {
        case .income(let income):
            
            // TODO: add link for income transfer
            
            router.navigateTo(.incomes)
            print(income.title)
            
            return true
            
        case .accountAndGroups(let accountsAndGroups):
            print("Type of accountsAndGroups:", type(of: accountsAndGroups)) // Покажет текущий тип
            print(accountsAndGroups.title)
            
            guard let account = accountsAndGroups as? Account else {
                print("error: accountsAndGroups is not Account, but \(type(of: accountsAndGroups))")
                return false
            }
            
            print("Account dragged:", account.title)
            router.navigateTo(.transfer(sourse: account, destination: destination))
            return true
        }
    }
}

//#Preview {
//    let groups = CategoryService().groupsOfAccounts
//    let accounts = CategoryService().accounts
//    return AccountsAndGroupsScrollView(accounts: accounts, groups: groups).environment(Router.shared)
//}
