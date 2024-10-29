//
//  AccountGroupCapsuleView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 26.09.24.
//

import SwiftUI
import UISystem

struct AccountGroupCapsuleView: View {
    let accountsGroup: GroupOfAccounts
    @Binding var selectedAccount: Account?
    
    @Binding var isExpanded: Bool
    
    var countOfAccounts: Int {
        accountsGroup.accounts.count
    }
    
    var backgroundColor: LinearGradient {
        AppGradient.getColor(from: accountsGroup.color)?.value ?? AppGradient.appWhite.value
    }
    
    var body: some View {
        HStack{
            if isExpanded {
                HStack(spacing: 16) {
                    Button(action: {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.subheadline)
                            .foregroundStyle(accountsGroup.color == AppGradient.appBlack.name ? .appWhite : .black)
                    }
                    .padding(.leading, 12)
                    ForEach(accountsGroup.accounts) { account in
                        AccountCapsuleView(
                            account: account,
                            isSelected: account.id == selectedAccount?.id,
                            onSelect: {
                                selectedAccount = account
                            }
                        )
                    }
                }
                .padding(8)
            } else {
                GroupCapsuleView(group: accountsGroup)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
            }
        }
        .frame(height: 76)
        .background(isExpanded ? backgroundColor : nil)
        .clipShape(Capsule())
        .animation(.spring(), value: isExpanded)
    }
}

#Preview {
    let group = DataManager.shared.getCategories(with: .groupOfAccounts).first as? GroupOfAccounts
    let account = group?.accounts.first
    
    return AccountGroupCapsuleView(accountsGroup: group!, selectedAccount: .constant(account), isExpanded: .constant(false))
}
