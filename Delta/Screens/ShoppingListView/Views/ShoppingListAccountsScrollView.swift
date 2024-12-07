//
//  ShoppingListAccountsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 26.09.24.
//

import SwiftUI

struct ShoppingListAccountsScrollView: View {
    @Environment(CategoryService.self) private var categoryService
    
    @Binding var selectedAccount: Account?
    @State private var isExpanded = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(categoryService.accountsAndGroups, id: \.id) { item in
                        if let account = item as? Account {
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
                        if let group = item as? GroupOfAccounts {
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
                    }
                }
            }
        }
        .onAppear {
            categoryService.getAccountsAndGroups()
        }
        .safeAreaPadding(.horizontal)
        .shadow()
    }
}

#Preview {
    let accounts = CategoryService().accounts
    let account = accounts.first!
    
    ShoppingListAccountsScrollView(selectedAccount: .constant(account))
}
