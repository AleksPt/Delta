//
//  AccountsAndGroupsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 16.10.24.
//

import SwiftUI

struct AccountsAndGroupsScrollView: View {
    @Environment(Router.self) private var router
    
    @State private var selectedGroup: GroupOfAccounts?
    @State private var isExpanded = false
    
    let categories: [Category]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderMainView(text: "Accounts", action: {
                // TODO: - add See all
            })
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(categories) { category in
                            if let account = category as? Account {
                                AccountCardView(
                                    account: account,
                                    size: CGSize(width: Constants.widthTwo, height: Constants.heightThree))
                            } else if let group = category as? GroupOfAccounts {
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
                            let account = Account(
                                id: UUID(),
                                title: "",
                                currency: .rub,
                                image: "",
                                color: "",
                                users: [],
                                transactions: [],
                                categoryType: .account
                            )
                            router.navigateTo(.accountSettings(account: account))
                        }
                    }
                }
                .shadow()
            }
        }
    }
}

#Preview {
    let group = DataManager.shared.getAccountsAndGroup()
    return AccountsAndGroupsScrollView(categories: group).environment(Router())
}
