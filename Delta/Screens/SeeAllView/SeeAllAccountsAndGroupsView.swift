//
//  SeeAllAccountsAndGroupsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 08.12.24.
//

import SwiftUI

struct SeeAllAccountsAndGroupsView: View {
    @Environment(CategoryService.self) private var categoryService
    @Environment(Router.self) private var router
    
    @State private var isTargetedGroupIDs: [UUID: Bool] = [:]
    @State private var isLastGroup: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(categoryService.accountsAndGroups, id: \.id) { item in
                    if let account = item as? Account {
                        AddAccountOrGroupView(
                            isTargeted: Binding(
                                get: { isTargetedGroupIDs[item.id] ?? false },
                                set: { isTargetedGroupIDs[item.id] = $0 }
                            )
                        )
                        
                        .dropDestination(for: Account.self) { items, location in
                            for item in items {
                                print("Drop \(item.title)")
                            }
                            
                            return true
                        } isTargeted: { isTargeted in
                            isTargetedGroupIDs[item.id] = isTargeted
                        }
                        
                        AccountRowView(account: account)
                        
                    } else if let group = item as? GroupOfAccounts {
                        
                        AddAccountOrGroupView(
                            isTargeted: Binding(
                                get: { isTargetedGroupIDs[item.id] ?? false },
                                set: { isTargetedGroupIDs[item.id] = $0 }
                            )
                        )
                        
                        .dropDestination(for: Account.self) { items, location in
                            for item in items {
                                print("Drop \(item.title)")
                            }
                            
                            return true
                        } isTargeted: { isTargeted in
                            isTargetedGroupIDs[item.id] = isTargeted
                        }
                        
                        GroupRowView(group: group)
                    }
                }
                
                AddAccountOrGroupView(isTargeted: .constant(false))
                
            }
        }
        .navigationBarTitle("Accounts and Groups")
        .navigationBarTitleDisplayMode(.large)
        .background(.appBackground)
        .safeAreaPadding()
        .shadow()
        
        .toolbar {
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
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    SeeAllAccountsAndGroupsView()
        .environment(CategoryService())
        .environment(Router.shared)
}
