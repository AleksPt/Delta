//
//  GroupRowView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.12.24.
//

import SwiftUI
import UISystem

struct GroupRowView: View {
    @Environment(Router.self) private var router
    
    let group: GroupOfAccounts
    
    @State private var isTargetedAccountIDs: [UUID: Bool] = [:]
    @State private var isLastAccount: Bool = false
    
    var body: some View {
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
            
            VStack(spacing: 0) {
                ForEach(group.accounts) { account in
                    
                    // Вставить счет в группу
                    AddAccountOrGroupView(
                        isTargeted: Binding(
                            get: { isTargetedAccountIDs[account.id] ?? false },
                            set: { isTargetedAccountIDs[account.id] = $0 }
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
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isTargetedAccountIDs[account.id] = isTargeted
                            }
                        }
                    }
                    
                    AccountRowView(account: account)
                }
                
                // Вставить последний счет группу
                AddAccountOrGroupView(isTargeted: $isLastAccount)
                
                    .dropDestination(for: DragDropItem.self) { items, location in
                        for item in items {
                            
                            // TODO: - setup logic
                            
                            print(item.accountAndGroups?.title ?? "Unknown")
                            print(group.title)
                        }
                        
                        return true
                    } isTargeted: { isTargeted in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isLastAccount = isTargeted
                            }
                        }
                    }
                Spacer(minLength: 16)
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
}

#Preview {
    let group = DataStore.shared.groupsOfAccounts.last!
    GroupRowView(group: group)
        .environment(Router.shared)
}
