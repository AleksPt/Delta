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
    
    @State private var isTargetedAccountOrGroupIDs: [UUID: Bool] = [:]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(categoryService.accountsAndGroups, id: \.id) { item in
                    if let account = item as? Account {
                        
                        // Вставить элемент во все счета и группы по индексу
                        AccountRowView(
                            account: account,
                            isTargeted: Binding(
                                get: { isTargetedAccountOrGroupIDs[item.id] ?? false },
                                set: { isTargetedAccountOrGroupIDs[item.id] = $0 }
                            )
                        )
                        
                        .dropDestination(for: DragDropItem.self) { items, location in
                            for item in items {
                                
                                // TODO: - setup logic
                                
                                // 0. Проверить не совпадают ли UUID
                                
                                // 1. Получить UUID входящего элемента
                                // 2. Определить источник входящего элемента
                                // 3. Удалить из источника входящий элемент
                                
                                // 4. Получить UUID назначения
                                // 5. Определяем индекс назначения
                                // 6. Поместить входящий элемент по индексу accountsAndGroups
                                
                                print(item.accountAndGroups?.title ?? "Unknown")
                                print(account.title)
                            }
                            return true
                        } isTargeted: { isTargeted in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.spring()) {
                                    isTargetedAccountOrGroupIDs[item.id] = isTargeted
                                }
                            }
                        }
                        
                    } else if let group = item as? GroupOfAccounts {
                        
                        // Вставить элемент во все счета и группы по индексу

                        GroupRowView(
                            group: group,
                            isTargeted: Binding(
                                get: { isTargetedAccountOrGroupIDs[group.id] ?? false },
                                set: { isTargetedAccountOrGroupIDs[group.id] = $0 }
                            )
                        )
                            .dropDestination(for: DragDropItem.self) { items, location in
                                for item in items {
                                    
                                    // TODO: - setup logic
                                    
                                    // 0. Проверить не совпадают ли UUID
                                    
                                    // 1. Получить UUID входящего элемента
                                    // 2. Определить источник входящего элемента
                                    // 3. Удалить из источника входящий элемент
                                    
                                    // 4. Получить UUID назначения
                                    // 5. Определяем индекс назначения
                                    // 6. Поместить входящий элемент по индексу accountsAndGroups
                                    
                                    print(item.accountAndGroups?.title ?? "Unknown")
                                    print(group.title)
                                }
                                return true
                            } isTargeted: { isTargeted in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation(.spring()) {
                                        isTargetedAccountOrGroupIDs[item.id] = isTargeted
                                    }
                                }
                            }
                    }
                }
                
                // Вставить последний во все счета и группы
                
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
                    AddAccountOrGroupView(isTargeted: .constant(true))
                }
                .dropDestination(for: DragDropItem.self) { items, location in
                    for item in items {
                        
                        // TODO: - setup logic
                        
                        // 1. Получить UUID входящего элемента
                        // 2. Определить источник входящего элемента
                        // 3. Удалить из источника входящий элемент
                        // 4. Поместить входящий элемент в конец accountsAndGroups
                        
                        print(item.accountAndGroups?.title ?? "Unknown")
                        print(categoryService.groupsOfAccounts.count)
                    }
                    return true
                }
                
            }
        }
        .navigationBarTitle("Accounts and Groups")
        .navigationBarTitleDisplayMode(.large)
        .background(.appBackground)
        .safeAreaPadding()
        .shadow()
        
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
