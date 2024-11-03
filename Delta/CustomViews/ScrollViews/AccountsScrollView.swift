//
//  AccountsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 16.10.24.
//

import SwiftUI

struct AccountsScrollView: View {
    @Environment(Router.self) private var router
    
    let accounts: [Account]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(accounts) { account in
                    AccountCardView(
                        account: account,
                        size: CGSize(width: Constants.widthTwo, height: Constants.heightThree))
                    
                }
                
                PlusButtonView {
                    router.navigateTo(.accountCreate)
                }
            }
        }
        .shadow()
    }
}

#Preview {
    let accounts = DataStore.shared.accounts
    return AccountsScrollView(accounts: accounts).environment(Router.shared)
}
