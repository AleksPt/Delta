//
//  SeeAllAccounts.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 10/23/24.
//

import SwiftUI
import UISystem

struct SeeAllAccounts: View {
    @Environment(CategoryService.self) private var categoryService
    @Environment(Router.self) private var router
    
    @Binding var accounts: [Category]
    
    var body: some View {
        VStack {
            Text("Choose accounts for group")
                .font(.heading1())
                .foregroundStyle(AppGradient.appBlack.value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            List {
                ForEach(categoryService.accounts) { account in
                    HStack {
                        AccountCardView(
                            account: account,
                            size: CGSize(width: Constants.widthTwo, height: Constants.heightThree)
                        )
                        Spacer()
                        Image(systemName: accounts.contains(account) ? "checkmark.circle.fill" : "circle")
                            .font(.title)
                            .foregroundStyle(AppGradient.appBlack.value)
                        
                    }
                    .listRowBackground(AppGradient.appBackgroundMini.value)
                    .padding(.vertical, 4)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        //categoryService.manageAccounts(for: group, and: account)
                        setCheckmarks(for: account)
                    }
                }
            }
            .listSectionSpacing(.compact)
            .scrollContentBackground(.hidden)
            .background(.appBackground)
            .padding(.top, -10)
            
            RoundedButtonView(title: "Save accounts") {
                router.dismissModal()
            }
            .contentShape(Rectangle())
            .padding(20)
            .onTapGesture {
                router.dismissModal()
            }
        }
        .background(.appBackground)
    }
    
    private func setCheckmarks(for account: Account) {
        if accounts.contains(account) {
            if let index = accounts.firstIndex(where: { $0.id == account.id }) {
                accounts.remove(at: index)
            }
        } else {
            accounts.append(account)
        }
    }
}


//#Preview {
//    SeeAllAccounts()
//        .environment(Router.shared)
//        .environment(CategoryService())
//}
