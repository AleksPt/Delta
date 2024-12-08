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
    let size: CGSize
    
    @Binding var isExpanded: Bool
    
    @State private var isHoveringOnGroup = false
    @State private var isHoveringOnAccount = false
    
    var countOfAccounts: Int {
        accountsGroup.accounts.count
    }
    
    var backgroundColor: LinearGradient {
        AppGradient.getAppGradient(from: accountsGroup.color)?.value ?? AppGradient.appWhite.value
    }
    
    var body: some View {
        
        ZStack{
            if !isExpanded {
                backgroundColor.brightness(-0.1)
                    .frame(width: Constants.widthTwo - 32, height: Constants.heightThree)
                    .cornerRadius(16)
                    .offset(y: -8)
                
                backgroundColor.brightness(-0.07)
                    .frame(width: Constants.widthTwo - 16, height: Constants.heightThree)
                    .cornerRadius(16)
                    .offset(y: -4)
                
            }
            
            VStack(alignment: .trailing) {
                if !isExpanded {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(LocalizedStringKey(accountsGroup.title))
                                .font(.subheading1())
                            Spacer(minLength: 0)
                            
                            Text(accountsGroup.totalAmount.formattedAmount(for: accountsGroup.currency))
                                .font(.metadata3())
                        }
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                }
                
                HStack(alignment: .center) {
                    ForEach(accountsGroup.accounts) { account in
                        HStack(spacing: 8) {
                            AccountCardView(
                                account: account,
                                size: CGSize(width: Constants.widthTwo, height: Constants.heightThree),
                                groupColor: accountsGroup.color,
                                isGroupNotExpanded: $isExpanded
                            )
                            .draggable(account)
                            
                            .dropDestination(for: DragDropItem.self) { droppedItems, _ in
                                return router.dropTransfer(items: droppedItems, destination: account)
                            } isTargeted: { isTargeted in
                                isHoveringOnAccount = isTargeted
                            }
                        }
                    }
                    Spacer()
                    if !isExpanded {
                        Image(systemName: accountsGroup.image)
                            .font(.bodyText2())
                    } else {
                        VStack {
                            Button(action: {
                                withAnimation(.spring()) {
                                    isExpanded.toggle()
                                }
                            }) {
                                Image(systemName: "arrow.backward")
                                    .font(.subheadline)
                            }
                            .padding(.bottom)
                            
                            Button(action: {
                                router.navigateTo(.accountGroupSettings(group: accountsGroup))
                            }) {
                                Image(systemName: "gearshape")
                                    .font(.subheadline)
                                    .padding(.top)
                            }
                        }
                    }
                }
            }
            .foregroundStyle(AppGradient.getColor(from: accountsGroup.color))
            .padding()
            
            .frame(minWidth: size.width)
            .frame(height: isExpanded ? size.height + 16 : size.height)
            
            .background(backgroundColor)
            .cornerRadius(isExpanded ? 24 : 16)
            
            .onTapGesture {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }
        }
        
        .dropDestination(for: DragDropItem.self) { _, _ in
            return false
        } isTargeted: { isTargeted in
            isHoveringOnGroup = isTargeted
            withAnimation(.spring()) {
                isExpanded = true
            }
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
    AccountGroupCardView(
        accountsGroup: group,
        size: CGSize(width: Constants.widthTwo, height: Constants.heightThree),
        isExpanded: .constant(false)
    )
        .environment(Router.shared)
}
