//
//  AccountGroupCardView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 28.08.24.
//

import SwiftUI
import UISystem

struct AccountGroupCardView: View {
    @Environment(Router.self) private var router
    
    let accountsGroup: GroupOfAccounts
    let onSelect: () -> Void
    
    @State private var isExpanded = false
    @State private var isDragging: Bool = false
    @State private var droppedAccount: Account? //TODO: - !!!
    
    var countOfAccounts: Int {
        accountsGroup.accounts.count
    }
    
    var backgroundColor: LinearGradient {
        AppGradient.getColor(from: accountsGroup.color)?.value ?? AppGradient.appWhite.value
    }
    
    var body: some View {
        VStack{
            if isExpanded {
                HStack(spacing: 16) {
                    VStack {
                        Button(action: {
                            withAnimation(.spring()) {
                                isExpanded.toggle()
                            }
                        }) {
                            Image(systemName: "arrow.backward")
                                .font(.subheadline)
                                .foregroundStyle(accountsGroup.color == AppGradient.appBlack.name ? .appWhite : .black)
                        }
                        .padding(.bottom)
                        
                        Button(action: {
                            router.navigateTo(.accountGroupSettings(group: accountsGroup))
                        }) {
                            Image(systemName: "gearshape")
                                .font(.subheadline)
                                .foregroundStyle(accountsGroup.color == AppGradient.appBlack.name ? .appWhite : .black)
                                .padding(.top)
                        }
                    }
                    
                    ForEach(accountsGroup.accounts) { account in
                        AccountCardView(
                            account: account,
                            size: CGSize(width: Constants.widthTwo, height: Constants.heightThree)
                        )
                        .draggable(account)
//                        .dropDestination(for: Account.self) { droppedAccounts, location in
//                            droppedAccount = droppedAccounts.first
//                            guard let droppedAccount else { return false }
//                            router.navigateTo(.transfer(sourse: droppedAccount, destination: account))
//                            return true
//                        } isTargeted: { isTargeted in
//                            // change appearance
//                        } //TODO: - !!!
                    }
                }
                .padding()
            } else {
                GroupCardView(group: accountsGroup, size: CGSize(width: Constants.widthTwo, height: Constants.heightThree))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                            onSelect()
                        }
                    }
            }
        }
        .frame(
            height: Constants.heightThree + 16
        )
        .background(isExpanded ? backgroundColor : nil)
        .cornerRadius(isExpanded ? 24 : 16)
        .animation(.spring(), value: isExpanded)
        
        .onChange(of: isDragging) { _, isDragging in
            if isDragging {
                isExpanded = true
            }
        }
        
        .dropDestination(for: DragDropItem.self) { droppedCategories, location in
            isExpanded.toggle()
            return true
        } isTargeted: { isTargeted in
            isDragging = isTargeted
        }
    }
}

#Preview {
    let group = CategoryService().groupsOfAccounts.first!
    return AccountGroupCardView(accountsGroup: group, onSelect: {})
}
