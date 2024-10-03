//
//  AccountGroupSettingsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI
import UISystem

struct AccountGroupSettingsView: View {
    @EnvironmentObject var router: Router
    
    @State private var name: String
    @State private var currency: Currency
    @State private var balance: String
    @State private var selectedIcon: Icon
    @State private var selectedColor: AppGradient
    @State private var accounts: [Category] = []
    
    let groupOfAccounts: GroupOfAccounts
    let dataManager = DataManager.shared
    
    init(groupOfAccounts: GroupOfAccounts) {
        self.groupOfAccounts = groupOfAccounts
        _name = State(initialValue: groupOfAccounts.title)
        _currency = State(initialValue: groupOfAccounts.currency)
        _balance = State(initialValue: String(groupOfAccounts.amount))
        _selectedIcon = State(initialValue: Icon.getIcon(from: groupOfAccounts.image) ?? .dollar)
        _selectedColor = State(initialValue: AppGradient.getColor(from: groupOfAccounts.color) ?? .blueGradient)
        _accounts = State(initialValue: dataManager.getAccounts())
    }
    
    var body: some View {
        List {
            AccountLargeCardView(
                title: name,
                currency: currency,
                amount: balance,
                image: selectedIcon.name,
                color: selectedColor.name,
                size: CGSize(width: Constants.widthThree, height: Constants.heightSix)
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            
            Section {
                CategoriesScrollView(categories: accounts)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            } header: {
                Text("Accounts")
                    .font(.subheading1())
                    .padding(.leading, -18)
                    .foregroundStyle(AppGradient.appBlack.value)
            }
            
            Section {
                TextFieldRowView(
                    inputValue: $name,
                    source: groupOfAccounts,
                    title: "Account name",
                    keyboardType: .default, 
                    placeholder: groupOfAccounts.title
                )
                
                PickerRowView(
                    currency: $currency,
                    source: groupOfAccounts,
                    title: "Currency"
                )
            } header: {
                Text("Account settings")
                    .font(.subheading1())
                    .padding(.leading, -18)
                    .foregroundStyle(AppGradient.appBlack.value)
            }
            
            Section {
                HStack(spacing: 16) {
                    ChosingItemView(
                        selectedItem: $selectedIcon,
                        items: Icon.allCases,
                        title: "Icon",
                        size: CGSize(width: Constants.widthHalfScreen, height: Constants.heightFour)
                    )
                    
                    ChosingItemView(
                        selectedItem: $selectedColor,
                        items: AppGradient.allCases,
                        title: "Color",
                        size: CGSize(width: Constants.widthHalfScreen, height: Constants.heightFour)
                    )
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .padding(.vertical, 8)
            
            RoundedButtonView(title: "Delete group", action: {})
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .padding(.top, 8)
        }
        .buttonStyle(BorderlessButtonStyle())
        .listSectionSpacing(.compact)
        .navigationTitle(groupOfAccounts.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    //сохраняем изменения
                }
            }
        }
        .background(.appBackground)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    AccountGroupSettingsView(
        groupOfAccounts: GroupOfAccounts(
            id: UUID(),
            title: "Alfa bank",
            currency: .usd,
            image: "dollarsign.circle",
            color: AppGradient.blueGradient.name,
            accounts: DataStore.shared.accounts,
            categoryType: .account
        )
    )
}
