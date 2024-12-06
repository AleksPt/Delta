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
    
    @Binding var isExpanded: Bool
    
    @State private var isHoveringOnGroup = false
    @State private var isHoveringOnAccount = false
    
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
                        
                        .dropDestination(for: DragDropItem.self) { droppedItems, _ in
                            return router.dropTransfer(items: droppedItems, destination: account)
                        } isTargeted: { isTargeted in
                            isHoveringOnAccount = isTargeted
                        }
                    }
                }
                .padding()
            } else {
                GroupCardView(group: accountsGroup, size: CGSize(width: Constants.widthTwo, height: Constants.heightThree))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
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
        
        .dropDestination(for: DragDropItem.self) { _, _ in
            return false
        } isTargeted: { isTargeted in
            isHoveringOnGroup = isTargeted
            isExpanded = true
        }
        
        .onChange(of: isHoveringOnAccount) { _, _ in
            updateExpandedState()
        }
        .onChange(of: isHoveringOnGroup) { _, _ in
            updateExpandedState()
        }
    }
    
    private func updateExpandedState() {
        if !isHoveringOnAccount && !isHoveringOnGroup {
            withAnimation(.spring()) {
                isExpanded = false
            }
        }
    }
}

#Preview {
    let group = CategoryService().groupsOfAccounts.first!
    AccountGroupCardView(accountsGroup: group, isExpanded: .constant(false))
        .environment(Router.shared)
}
