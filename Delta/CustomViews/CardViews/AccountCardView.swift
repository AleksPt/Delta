//
//  AccountCardView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 27.08.24.
//

import SwiftUI
import UISystem

struct AccountCardView: View {
    @EnvironmentObject var router: Router
    
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
    }
}

#Preview {
    let account = DataStore.shared.accounts.first!
    
    AccountCardView(
        account: account,
        size: CGSize(width: Constants.widthTwo, height: Constants.heightThree)
    )
}
