//
//  AccountRowView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 08.12.24.
//

import SwiftUI
import UISystem

struct AccountRowView: View {
    @Environment(Router.self) private var router
    
    let account: Account
    @Binding var isTargeted: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            if isTargeted {
                AddAccountOrGroupView(isTargeted: $isTargeted)
            }
            
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .frame(width: 38)
                        .foregroundStyle(AppGradient.getAppGradient(from: account.color)!.value)
                    
                    Image(systemName: account.image)
                        .resizable()
                        .frame(width: 18, height: 16)
                        .foregroundStyle(AppGradient.getColor(from: account.color))
                }
                
                Text(LocalizedStringKey(account.title))
                    .font(.subheading2())
                
                Spacer()
                
                Text("\(account.amount.formattedAmount(for: account.currency))")
                    .font(.bodyText1())
            }
            .padding()
            .background(.appBackgroundMini)
            .cornerRadius(16)
            .shadow()
            .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16), eoFill: true)
            
            .draggable(account)
            
            .onTapGesture {
                router.navigateTo(.accountSettings(account: account))
            }
        }
        
        .contentShape(Rectangle())
    }
}

#Preview {
    let account = DataStore.shared.accounts.first!
    AccountRowView(account: account, isTargeted: .constant(true))
        .environment(Router.shared)
}
