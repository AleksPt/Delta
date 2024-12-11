//
//  GroupRowView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.12.24.
//

import SwiftUI
import UISystem

struct GroupRowView: View {
    
    @Environment(CategoryService.self) private var categoryService
    @Environment(Router.self) private var router
    
    let group: GroupOfAccounts
    @Binding var isTargeted: Bool
    
    @State private var isTargetedAccountIDs: [UUID: Bool] = [:]
    
    var body: some View {
        VStack(spacing: 16) {
            if isTargeted {
                
                // Вставить счет в группу по индексу
                
                AddAccountOrGroupView(isTargeted: $isTargeted)
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .frame(width: 38)
                            .foregroundStyle(AppGradient.getAppGradient(from: group.color)!.value)
                        
                        Image(systemName: group.image)
                            .resizable()
                            .frame(width: 18, height: 16)
                            .foregroundStyle(AppGradient.getColor(from: group.color))
                    }
                    
                    Text(LocalizedStringKey(group.title))
                        .font(.subheading2())
                    
                    Spacer()
                    
                    Text("\(group.totalAmount.formattedAmount(for: group.currency))")
                        .font(.bodyText1())
                }
                
                VStack(spacing: 16) {
                    ForEach(group.accounts) { account in
                        
                        AccountRowView(
                            account: account,
                            isTargeted: Binding(
                                get: { isTargetedAccountIDs[account.id] ?? false },
                                set: { isTargetedAccountIDs[account.id] = $0 }
                            )
                        )
                        
                        .dropDestination(for: DragDropItem.self) { items, _ in
                            var result = true
                            let item = items.first!
                            
                            // Приводим DragDropItem к AccountAndGroups
                            guard let droppedItem = item.accountAndGroups else {
                                print("Invalid item")
                                result = false
                                return result
                            }
                            
                            // 1. Получить UUID входящего элемента
                            let droppedItemUUID = droppedItem.id
                            
                            // 2. Проверить не совпадают ли UUID
                            if droppedItemUUID == account.id {
                                print("Dragged item matches target, no action needed.")
                                result = false
                            }
                                
                            // 3. Проверить не является ли источник группой
                            if categoryService.groupsOfAccounts.contains(where: { $0.id == droppedItemUUID }) {
                                result = false
                                print(result)
                            } else {
                                
                                // 4. Удалить входящий элемент, не зависимо от уровня
                                print(categoryService.accounts)
                                print(result)
                                
                                categoryService.removeAccount(by: droppedItemUUID)
                                
                                print(categoryService.accounts)
                                
                                result = true
                                print(result)
                            }
                            
                            
                            return result
                            
                        } isTargeted: { isTargeted in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.spring()) {
                                    isTargetedAccountIDs[account.id] = isTargeted
                                }
                            }
                        }
                    }
                    
                    // Вставить последний в группу
                    
                    AddAccountOrGroupView(isTargeted: .constant(true))
                        .dropDestination(for: DragDropItem.self) { items, location in
                            for item in items {
                                
                                // TODO: - setup logic
                                
                                // 0. Проверить не совпадают ли UUID
                                
                                // 1. Получить UUID входящего элемента
                                // 2. Определить источник входящего элемента
                                // 3. Проверить не является ли источник группой
                                // 4. Удалить из источника входящий элемент
                                
                                // 5. Получить UUID назначения
                                // 6. Поместить входящий элемент в конец
                                
                                print(item.accountAndGroups?.title ?? "Unknown")
                                print(group.title)
                            }
                            
                            return true
                        }
                        .onTapGesture {
                            router.navigateTo(.accountCreate)
                        }
                }
            }
            .padding()
            .background(.appBackgroundMini)
            .cornerRadius(16)
            .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16), eoFill: true)
            
            .draggable(group)
            
            .onTapGesture {
                router.navigateTo(.accountGroupSettings(group: group))
            }
        }
        
        .contentShape(Rectangle())
    }
}

#Preview {
    let group = DataStore.shared.groupsOfAccounts.last!
    GroupRowView(group: group, isTargeted: .constant(true))
        .environment(CategoryService())
        .environment(Router.shared)
}
