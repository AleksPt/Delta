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
        
    let accounts: [Account]
    let groups: [GroupOfAccounts]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderMainView(text: "Accounts", action: {
                // TODO: - add See all
            })
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(groups) { group in
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
                        ForEach(accounts) { account in
                            AccountCardView(
                                account: account,
                                size: CGSize(width: Constants.widthTwo, height: Constants.heightThree))
                        }
                        
                        
                        PlusButtonView {
                            router.navigateTo(.accountCreate)
                        }
                    }
                }
            }
            .shadow()
        
        
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 16) {
//                        ForEach(categories) { category in
//                            if let account = category as? Account {
//                                AccountCardView(
//                                    account: account,
//                                    size: CGSize(width: Constants.widthTwo, height: Constants.heightThree)) 
//                            } else if let group = category as? GroupOfAccounts {
//                                AccountGroupCardView(accountsGroup: group, onSelect: {
//                                    selectedGroup = nil
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                        selectedGroup = group
//                                    }
//                                })
//                                .onChange(of: selectedGroup) { _, newValue in
//                                    if let selectedGroup = newValue {
//                                        withAnimation {
//                                            proxy.scrollTo(selectedGroup.id, anchor: .leading)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        
//                        PlusButtonView {
//                            
//                            router.navigateTo(.accountCreate)
//                        }
//                    }
//                }
//                .shadow()
        }
    }
}


#Preview {
    let groups = CategoryService().groupsOfAccounts
    let accounts = CategoryService().accounts
    return AccountsAndGroupsScrollView(accounts: accounts, groups: groups).environment(Router.shared)
}
