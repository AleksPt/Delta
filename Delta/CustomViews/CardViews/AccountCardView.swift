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
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                VStack(alignment: .leading) {
                    Text(account.title)
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
        .foregroundStyle(account.color == AppGradient.appBlack.name ? .appWhite : .black)
        .padding()
        .componentBackground(
            color: account.color,
            size: CGSize(width: size.width, height: size.height)
        )
        .onTapGesture {
            router.navigateTo(.accountSettings(account: account))
        }
        
        // TODO: - drag and drop
        
        .dropDestination(for: Account.self) { droppedCategories, location in
            router.navigateTo(.incomes)
            return true
        } isTargeted: { isTargeted in
            // change appearance
        }
        
        .draggable(account)
    }
}

#Preview {
    let account = DataStore.shared.accounts.first!
    
    return AccountCardView(
        account: account,
        size: CGSize(width: Constants.widthTwo, height: Constants.heightThree)
    )
}
