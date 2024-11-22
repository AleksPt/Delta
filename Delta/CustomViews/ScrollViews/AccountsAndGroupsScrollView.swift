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
    @State private var droppedAccount: Account?
    
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
                                .dropDestination(for: Account.self) { droppedAccounts, location in
                                    droppedAccount = droppedAccounts.first
                                    guard let droppedAccount else { return false }
                                    router.presentModal(.transfer(sourse: droppedAccount, destination: account))
                                    return true
                                } isTargeted: { isTargeted in
                                    // change appearance
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
}


//#Preview {
//    let groups = CategoryService().groupsOfAccounts
//    let accounts = CategoryService().accounts
//    return AccountsAndGroupsScrollView(accounts: accounts, groups: groups).environment(Router.shared)
//}
