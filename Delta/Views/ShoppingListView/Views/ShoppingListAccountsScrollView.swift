//
//  ShoppingListAccountsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 26.09.24.
//

import SwiftUI

struct ShoppingListAccountsScrollView: View {
    @Binding var selectedAccount: Account?
    @State private var isExpanded = false
    
    let accounts: [Account]
    let groups: [GroupOfAccounts]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(groups) { group in
                            AccountGroupCapsuleView(
                                accountsGroup: group,
                                selectedAccount: $selectedAccount,
                                isExpanded: $isExpanded
                            )
                            .onChange(of: selectedAccount) { _, newValue in
                                if let selectedAccount = newValue {
                                    withAnimation {
                                        proxy.scrollTo(selectedAccount.id, anchor: .leading)
                                    }
                                }
                            }
                    }
                    
                    ForEach(accounts) { account in
                        AccountCapsuleView(
                            account: account,
                            isSelected: account.id == selectedAccount?.id,
                            onSelect: {
                                selectedAccount = account
                                isExpanded = false
                            }
                        )
                        .id(account.id)
                        .onChange(of: selectedAccount) { _, newValue in
                            if let selectedAccount = newValue {
                                withAnimation {
                                    proxy.scrollTo(selectedAccount.id, anchor: .leading)
                                }
                            }
                        }
                    }

//                    ForEach(categories) { category in
//                        if let account = category as? Account {
//                            AccountCapsuleView(
//                                account: account,
//                                isSelected: account.id == selectedAccount?.id,
//                                onSelect: {
//                                    selectedAccount = account
//                                    isExpanded = false
//                                }
//                            )
//                            .id(account.id)
//                        }
//                        if let group = category as? GroupOfAccounts {
//                            AccountGroupCapsuleView(
//                                accountsGroup: group,
//                                selectedAccount: $selectedAccount,
//                                isExpanded: $isExpanded
//                            )
//                        }
//                    }
                }
            }
            
        }
        .safeAreaPadding(.horizontal)
        .shadow()
    }
}

#Preview {
    let groups = CategoryService().groupsOfAccounts
    let accounts = CategoryService().accounts
    let account = accounts.first!
    
    ShoppingListAccountsScrollView(selectedAccount: .constant(account), accounts: accounts, groups: groups)
}
