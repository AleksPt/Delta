//
//  AccountCapsuleView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 25.09.24.
//

import SwiftUI
import UISystem

struct AccountCapsuleView: View {
    let account: Account
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Image(systemName: account.image)
                    .font(.bodyText2())
                
                Text(account.title)
                    .font(.subheading1())
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .contentShape(.rect)
            }
            .foregroundStyle(account.color == AppGradient.appBlack.name ? .appWhite : .black)
        }
        .padding()
        .frame(height: 60)
        .background(AppGradient.getColor(from: account.color)?.value)
        .clipShape(Capsule())
        .onTapGesture {
            withAnimation(.interactiveSpring) {
                onSelect()
            }
        }
    }
}

#Preview {
    let account = DataStore.shared.accounts.first!
    
    return AccountCapsuleView(
        account: account,
        isSelected: false,
        onSelect: {}
    )
}

