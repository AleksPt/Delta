//
//  AccountCardView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 27.08.24.
//

import SwiftUI
import UISystem

struct AccountCardView: View {
    @Environment(Router.self) private var router
    
    let account: Account
    let size: CGSize
    var groupColor: String?
    
    @Binding var isGroupNotExpanded: Bool
    
    var backgroundColor: String {
        if isGroupNotExpanded {
           account.color
        } else {
            AppGradient.getAppGradient(from: groupColor ?? account.color)?.accentColor ?? AppGradient.appBlack.name
        }
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            if isGroupNotExpanded {
                HStack {
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey(account.title))
                            .font(.subheading1())
                        Spacer(minLength: 0)
                        
                        Text(account.amount.formattedAmount(for: account.currency))
                            .font(.metadata3())
                    }
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
                
                Image(systemName: account.image)
                    .font(.bodyText2())
            }
        }
        .foregroundStyle(AppGradient.getColor(from: account.color))
        .padding()
        .componentBackground(
            color: backgroundColor,
            size: CGSize(
                width: !isGroupNotExpanded ? 4 : size.width,
                height: !isGroupNotExpanded ? 4 : size.height
            )
        )
        .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16), eoFill: true)
        
        .onTapGesture {
            router.navigateTo(.accountSettings(account: account))
        }
    }
}

#Preview {
    let account = DataStore.shared.accounts.first!
    
    AccountCardView(
        account: account,
        size: CGSize(width: Constants.widthTwo, height: Constants.heightThree),
        groupColor: "textGray",
        isGroupNotExpanded: .constant(true)
    )
    .environment(Router.shared)
}
