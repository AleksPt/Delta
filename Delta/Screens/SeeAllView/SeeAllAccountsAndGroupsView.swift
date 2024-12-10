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
    @State private var isLastAccountOrGroup: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(categoryService.accountsAndGroups, id: \.id) { item in
                    if let account = item as? Account {
                        
                        // Вставить элемент во все счета и группы
                        AddAccountOrGroupView(
                            isTargeted: Binding(
                                get: { isTargetedGroupIDs[item.id] ?? false },
                                set: { isTargetedGroupIDs[item.id] = $0 }
                            )
                        )
                        
                        .dropDestination(for: DragDropItem.self) { items, location in
                            for item in items {
                                
                                // TODO: - setup logic
                                
                                print(item.accountAndGroups?.title ?? "Unknown")
                                print(account.title)
                            }
                            
                            return true
                        } isTargeted: { isTargeted in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.spring()) {
                                    isTargetedGroupIDs[item.id] = isTargeted
                                }
                            }
                        }
                        
                        AccountRowView(account: account)
                        
                    } else if let group = item as? GroupOfAccounts {
                        
                        // Вставить элемент во все счета и группы
                        AddAccountOrGroupView(
                            isTargeted: Binding(
                                get: { isTargetedGroupIDs[item.id] ?? false },
                                set: { isTargetedGroupIDs[item.id] = $0 }
                            )
                        )
                        
                        .dropDestination(for: DragDropItem.self) { items, location in
                            for item in items {
                                
                                // TODO: - setup logic
                                
                                print(item.accountAndGroups?.title ?? "Unknown")
                                print(group.title)
                            }
                            
                            return true
                        } isTargeted: { isTargeted in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.spring()) {
                                    isTargetedGroupIDs[item.id] = isTargeted
                                }
                            }
                        }
                        
                        GroupRowView(group: group)
                    }
                }
                
                // Вставить последний во все счета и группы
                AddAccountOrGroupView(isTargeted: $isLastAccountOrGroup)
                
                    .dropDestination(for: DragDropItem.self) { items, location in
                        for item in items {
                            
                            // TODO: - setup logic
                            
                            print(item.accountAndGroups?.title ?? "Unknown")
                            print(categoryService.groupsOfAccounts.count)
                        }
                        
                        return true
                    } isTargeted: { isTargeted in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()) {
                                isLastAccountOrGroup = isTargeted
                            }
                        }
                    }
                
                Spacer(minLength: 50)
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
        
        .onAppear {
            categoryService.getAccountsAndGroups()
        }
    }
}

#Preview {
    SeeAllAccountsAndGroupsView()
        .environment(CategoryService())
        .environment(Router.shared)
}
