//
//  AccountsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 16.10.24.
//

import SwiftUI

struct AccountsScrollView: View {
    @Environment(Router.self) private var router
    
    let categories: [Category]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories) { category in
                    if let account = category as? Account {
                        AccountCardView(
                            account: account,
                            size: CGSize(width: Constants.widthTwo, height: Constants.heightThree))
                    }
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
    let accounts = DataManager.shared.getCategories(with: .account)
    return AccountsScrollView(categories: accounts).environment(Router.shared)
}
