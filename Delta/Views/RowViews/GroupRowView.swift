//
//  GroupRowView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.12.24.
//

import SwiftUI
import UISystem

struct GroupRowView: View {
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
                    
                    AddAccountOrGroupView(
                        isTargeted: Binding(
                            get: { isTargetedAccountIDs[account.id] ?? false },
                            set: { isTargetedAccountIDs[account.id] = $0 }
                        )
                    )
                    
                    .dropDestination(for: Account.self) { items, location in
                        for item in items {
                            print("Drop \(item.title)")
                        }
                        
                        return true
                    } isTargeted: { isTargeted in
                        isTargetedAccountIDs[account.id] = isTargeted
                    }
                    
                    AccountRowView(account: account)
                }
                
                AddAccountOrGroupView(isTargeted: $isLastAccount)
                
                    .dropDestination(for: Account.self) { items, location in
                        for item in items {
                            print("Drop \(item.title)")
                        }
                        
                        return true
                    } isTargeted: { isTargeted in
                        isLastAccount = isTargeted
                    }
            }
        }
        .padding()
        .background(.appBackgroundMini)
        .cornerRadius(16)
        .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16), eoFill: true)
    }
}

#Preview {
    let group = DataStore.shared.groupsOfAccounts.last!
    GroupRowView(group: group)
}
