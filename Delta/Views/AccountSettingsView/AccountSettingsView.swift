//
//  AccountSettingsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI
import UISystem

struct AccountSettingsView: View {
    @Environment(CategoryService.self) private var categoryService
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var currency: Currency
    @State private var balance: String //TODO: - add in model?
    @State private var selectedIcon: Icon
    @State private var selectedColor: AppGradient
    @State private var selectedUser: Person //TODO: - add multiple choising
    @State private var selectedGroup: GroupOfAccounts
    
    let dataStore = DataStore.shared
    var account: Account?
    
    init(account: Account = Account(
            id: UUID(),
            title: "",
            currency: .usd,
            image: "dollar",
            color: "blueGradient",
            users: DataStore.shared.people,
            transactions: [],
            categoryType: .account,
            groupOfAccounts: "Main"
        )) {
        self.account = account
        _name = State(initialValue: account.title)
        _currency = State(initialValue: account.currency)
        _balance = State(initialValue: String(account.amount))
        _selectedIcon = State(initialValue: Icon.getIcon(from: account.image) ?? .dollar)
        _selectedColor = State(initialValue: AppGradient.getColor(from: account.color) ?? .blueGradient)
        _selectedUser = State(initialValue: account.users.first ?? DataStore.shared.people.first!)
        _selectedGroup = State(initialValue: CategoryService().getGroupOfAccounts(from: account.groupOfAccounts)!)
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
            
            Section {
                TextFieldRowView(
                    inputValue: $name,
                    title: "Account name",
                    keyboardType: .default, 
                    placeholder: "Your account"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
                
                PickerRowView(
                    currency: $currency,
                    title: "Currency"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
                
                TextFieldRowView(
                    inputValue: $balance,
                    title: "Account balance",
                    keyboardType: .decimalPad, 
                    placeholder: "0.0"
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
            
            Section {
                HStack(spacing: 16) {
                    ItemPickerView(
                        selectedItem: $selectedGroup,
                        items: dataStore.groupsOfAccounts,
                        title: "Group of Accounts",
                        size: CGSize(width: Constants.widthHalfScreen, height: Constants.heightFive)
                    )
                    
                    ItemPickerView(
                        selectedItem: $selectedUser,
                        items: dataStore.people,
                        title: "User",
                        size: CGSize(width: Constants.widthHalfScreen, height: Constants.heightFive)
                    )
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .padding(.bottom, 8)
            
            Section {
                ShowHistoryView(
                    title: "History",
                    buttonTitle: "Show",
                    action: {
                        //TODO: - router.navigateTo(.history)
                    },
                    size: CGSize(width: Constants.widthFive, height: Constants.heightFive)
                )
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            
            RoundedButtonView(title: "Delete account") {
                if categoryService.isAccountExist(account!.id) {
                    categoryService.removeAccount(by: account!.id)
                }
                
                dismiss()
                
                categoryService.accounts.forEach { account in
                    print(account.title)
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
                    account?.title = name
                    account?.currency = currency
                    account?.color = selectedColor.name
                    account?.image = selectedIcon.name
                    account?.groupOfAccounts = selectedGroup.title
                    
                    if !categoryService.isAccountExist(account!.id) {
                        categoryService.createAccount(account ?? Account(
                            id: UUID(),
                            title: "",
                            currency: .usd,
                            image: "dollar",
                            color: "blueGradient",
                            users: DataStore.shared.people,
                            transactions: [],
                            categoryType: .account,
                            groupOfAccounts: "Main"
                        ))
                    }
                    
                    dismiss()
                    
                    categoryService.accounts.forEach { account in
                        print(account.title)
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
}



#Preview {
    AccountSettingsView(
        account: Account(
            id: UUID(),
            title: "Alfa bank",
            currency: .rub,
            image: "dollarsign.circle",
            color: AppGradient.redGradient.name,
            users: [],
            transactions: [],
            categoryType: .account,
            groupOfAccounts: "Main"
        )
    )
    .environment(Router.shared)
    .environment(CategoryService())
}
