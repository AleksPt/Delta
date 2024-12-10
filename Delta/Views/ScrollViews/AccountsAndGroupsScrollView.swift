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

    @Binding var expandedGroupID: UUID?
    @Binding var accountsAndGroups: [AccountsAndGroups]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderMainView(text: "Accounts", action: {
                // TODO: - add See all
            })
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(accountsAndGroups, id: \.id) { item in
                            if let account = item as? Account {
                                AccountCardView(
                                    account: account,
                                    size: CGSize(width: Constants.widthTwo, height: Constants.heightThree),
                                    isGroupNotExpanded: .constant(true)
                                )
                                .draggable(account)
                                
                                .dropDestination(for: DragDropItem.self) { droppedItems, _ in
                                    return router.dropTransfer(items: droppedItems, destination: account)
                                }
                                
                            } else if let group = item as? GroupOfAccounts {
                                
                                AccountGroupCardView(
                                    accountsGroup: group,
                                    size: CGSize(width: Constants.widthTwo, height: Constants.heightThree),
                                    isExpanded: Binding(
                                        get: { expandedGroupID == group.id },
                                        set: { isExpanded in
                                            expandedGroupID = isExpanded ? group.id : nil
                                        }
                                    )
                                )
                                .onChange(of: expandedGroupID) { _, newValue in
                                    if let expandedGroupID = newValue {
                                        withAnimation {
                                            proxy.scrollTo(expandedGroupID, anchor: .leading)
                                        }
                                    }
                                }
                            }
                        }
                    
                        Menu {
                            Button(action: {
                                router.navigateTo(.accountCreate)
                            }) {
                                Label("Add account", systemImage: "creditcard")
                            }
                            Button(action: {
                                router.navigateTo(.accountGroupCreate)
                            }) {
                                Label("Add group", systemImage: "rectangle.stack")
                            }
                        } label: {
                            PlusButtonView {}
                                .frame(width: Constants.widthOne)
                        }
                    }
                    .frame(height: Constants.heightOne + 24)
                }
            }
            .shadow()
        }
    }
}

#Preview {
    let someUUID = UUID()
    AccountsAndGroupsScrollView(expandedGroupID: .constant(someUUID), accountsAndGroups: .constant(CategoryService().accountsAndGroups))
        .environment(CategoryService())
        .environment(Router.shared)
}
