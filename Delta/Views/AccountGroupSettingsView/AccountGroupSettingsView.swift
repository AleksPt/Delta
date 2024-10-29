//
//  AccountGroupSettingsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI
import UISystem

struct AccountGroupSettingsView: View {
    @Environment(CategoryService.self) private var categoryService
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var currency: Currency
    @State private var balance: String
    @State private var selectedIcon: Icon
    @State private var selectedColor: AppGradient
    @State private var accounts: [Account] = []
    
    let dataManager = DataManager.shared
    var groupOfAccounts: GroupOfAccounts?
    
    init(groupOfAccounts: GroupOfAccounts = GroupOfAccounts(
        id: UUID(),
        title: "Alfa bank",
        currency: .usd,
        image: "dollarsign.circle",
        color: AppGradient.blueGradient.name,
        accounts: DataStore.shared.accounts,
        categoryType: .groupOfAccounts
    )) {
        self.groupOfAccounts = groupOfAccounts
        _name = State(initialValue: groupOfAccounts.title)
        _currency = State(initialValue: groupOfAccounts.currency)
        _balance = State(initialValue: String(groupOfAccounts.amount))
        _selectedIcon = State(initialValue: Icon.getIcon(from: groupOfAccounts.image) ?? .dollar)
        _selectedColor = State(initialValue: AppGradient.getColor(from: groupOfAccounts.color) ?? .blueGradient)
        _accounts = State(initialValue: groupOfAccounts.accounts)
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
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 14, trailing: 0))
            
            Section(header: headerView) {
                AccountsScrollView(accounts: accounts)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            }
            
            Section {
                TextFieldRowView(
                    inputValue: $name,
                    title: "Account name",
                    keyboardType: .default, 
                    placeholder: "Your title"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
                
                PickerRowView(
                    currency: $currency,
                    title: "Currency"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
            } header: {
                Text("Account settings")
                    .font(.subheading1())
                    .padding(.leading, -18)
                    .padding(.bottom, 8)
                    .foregroundStyle(AppGradient.appBlack.value)
            }
            
            Section {
                HStack(spacing: 16) {
                    IconPickerView(
                        selectedItem: $selectedIcon,
                        items: Icon.allCases,
                        title: "Icon"
                    )
                    
                    ColorPickerView(
                        selectedItem: $selectedColor,
                        items: AppGradient.allCases,
                        title: "Color"
                    )
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .padding(.vertical, 8)
            
            RoundedButtonView(title: "Delete group") {
                if categoryService.isGroupOfAccountsExist(groupOfAccounts!.id) {
                    categoryService.removeGroupOfAccounts(by: groupOfAccounts!.id)
                }
                
                dismiss()
                
                categoryService.groupsOfAccounts.forEach { groupOfAccounts in
                    print(groupOfAccounts.title)
                }
            }
            .buttonStyle(.borderless)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .padding(.top, 8)
        }
        .buttonStyle(.borderless)
        .listSectionSpacing(.compact)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    groupOfAccounts?.title = name
                    groupOfAccounts?.currency = currency
                    groupOfAccounts?.image = selectedIcon.name
                    groupOfAccounts?.color = selectedColor.name
                    groupOfAccounts?.accounts = accounts
                    
                    if !categoryService.isGroupOfAccountsExist(groupOfAccounts!.id) {
                        categoryService.createGroupOfAccounts(groupOfAccounts ?? GroupOfAccounts(
                            id: UUID(),
                            title: "Alfa bank",
                            currency: .usd,
                            image: "dollarsign.circle",
                            color: AppGradient.blueGradient.name,
                            accounts: categoryService.accounts,
                            categoryType: .groupOfAccounts
                        ))
                    }
                    
                    dismiss()
                    
                    categoryService.groupsOfAccounts.forEach { groupOfAccounts in
                        print(groupOfAccounts.title)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.appBackground)
        .padding(.top, -20)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Accounts")
                .font(.subheading1())
                .foregroundStyle(.appBlack)
            
            Spacer()
            
            ChevronButtonView() {
                router.presentModal(.seeAllAccounts(accounts: $accounts))
            }
            .textCase(.none)
        }
        .padding(.bottom, 6)
        .padding(.horizontal, -16)
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
    .environment(Router.shared)
    .environment(CategoryService())
}
