//
//  ShoppingListAccountsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 26.09.24.
//

import SwiftUI

struct ShoppingListAccountsScrollView: View {
    let categories: [Category]
    @Binding var selectedAccount: Account?
    @State private var isExpanded = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(categories) { category in
                        if let account = category as? Account {
                            AccountCapsuleView(
                                account: account,
                                isSelected: account.id == selectedAccount?.id,
                                onSelect: {
                                    selectedAccount = account
                                    isExpanded = false
                                }
                            )
                            .id(account.id)
                        }
                        if let group = category as? GroupOfAccounts {
                            AccountGroupCapsuleView(
                                accountsGroup: group,
                                selectedAccount: $selectedAccount,
                                isExpanded: $isExpanded
                            )
                        }
                    }
                }
            }
            .onChange(of: selectedAccount) { _, newValue in
                if let selectedAccount = newValue {
                    withAnimation {
                        proxy.scrollTo(selectedAccount.id, anchor: .leading)
                    }
                }
            }
        }
        .safeAreaPadding(.horizontal)
        .shadow()
    }
}

#Preview {
    let group = DataManager.shared.getAccountsAndGroup()
    let account = group.first(where: { $0.categoryType == .account })
    
    return ShoppingListAccountsScrollView(categories: group, selectedAccount:.constant(account as? Account))
}
