//
//  Untitled.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 10/14/24.
//

import SwiftUI
import UISystem

struct ExpenseSettingsView: View {
    @Environment(CategoryService.self) private var categoryService
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedType: RepeatingType = .random
    @State private var title: String = ""
    @State private var currency: Currency = .usd
    @State private var amount: String = ""
    @State private var icon: Icon = .dollar
    
    var expense: Expense?
    
    init(expense: Expense = Expense(
        amount: 0,
        image: "",
        repeatingType: .random,
        subCategories: [],
        transactions: [],
        id: UUID(),
        title: "",
        currency: .usd,
        categoryType: .expense
    )) {
        self.expense = expense
    }

    var body: some View {
        VStack {
            CustomSegmentedControlView(selection: $selectedType)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            
            switch selectedType {
            case .random:
                RandomExpensesView(
                    title: $title,
                    currency: $currency,
                    amount: $amount,
                    icon: $icon
                )
                .padding(.top, -10)
            case .certain:
                CertainExpensesView(
                    title: $title,
                    currency: $currency,
                    icon: $icon
                )
                .padding(.top, -10)
            }
        }
        .navigationTitle("Expense source")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    expense?.title = title
                    expense?.currency = currency
                    expense?.amount = Double(amount) ?? 0
                    expense?.image = icon.name
                    expense?.repeatingType = selectedType
                    expense?.subCategories = categoryService.getSubExpenses()
                    
                    categoryService.createExpense(expense ?? Expense(
                        amount: 0,
                        image: "",
                        repeatingType: .random,
                        subCategories: [],
                        transactions: [],
                        id: UUID(),
                        title: "",
                        currency: .usd,
                        categoryType: .expense
                    ))
                    categoryService.subCategories.removeAll()
                    
                    dismiss()
                    
                    categoryService.expenses.forEach { expense in
                        print(expense.title)
                    }
                }
            }
        }
        .background(.appBackground)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct RandomExpensesView: View {
    @Binding var title: String
    @Binding var currency: Currency
    @Binding var amount: String
    @Binding var icon: Icon

    var body: some View {
        List {
            Section {
                TextFieldRowView(
                    inputValue: $title,
                    title: "Expense title",
                    keyboardType: .default,
                    placeholder: "New expense"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
                
                PickerRowView(
                    currency: $currency,
                    title: "Currency"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
                
                TextFieldRowView(
                    inputValue: $amount,
                    title: "Amount",
                    keyboardType: .decimalPad,
                    placeholder: "0.0"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
            } header: {
                Text("Expense main info")
                    .font(.bodyText1())
                    .padding(.bottom, 6)
            }
            
            IconPickerView(
                selectedItem: $icon,
                items: Icon.allCases,
                title: "Icon"
            )
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .padding(.vertical, 8)
        }
        .buttonStyle(.borderless)
        .scrollContentBackground(.hidden)
        .listSectionSpacing(.compact)
    }
}

struct CertainExpensesView: View {
    @Environment(CategoryService.self) private var categoryService
    @Binding var title: String
    @Binding var currency: Currency
    @Binding var icon: Icon
    
    var body: some View {
        List {
            Section {
                TextFieldRowView(
                    inputValue: $title,
                    title: "Expense title",
                    keyboardType: .default,
                    placeholder: "New Expense"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
                
                PickerRowView(
                    currency: $currency,
                    title: "Currency"
                )
                .listRowBackground(AppGradient.appBackgroundMini.value)
            } header: {
                Text("Expense main info")
                    .font(.bodyText1())
                    .padding(.bottom, 6)
            }
            
            IconPickerView(
                selectedItem: $icon,
                items: Icon.allCases,
                title: "Icon"
            )
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .padding(.vertical, 8)
            
            ForEach(categoryService.subCategories.indices, id: \.self) { index in
                CertainExpenseSettingsView(
                    certainExpense: categoryService.subCategories[index],
                    action: {
                        categoryService.removeSubCategory(at: index)
                    }
                )
            }
            
            PlusButtonView {
                categoryService.createSubExpense()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            
        }
        .buttonStyle(.borderless)
        .scrollContentBackground(.hidden)
        .listSectionSpacing(.compact)
        .onAppear {
            if categoryService.subCategories.isEmpty {
                categoryService.createSubExpense()
            }
        }
    }
}

struct CertainExpenseSettingsView: View {
    @Bindable var certainExpense: SubCategory
    @State private var amount: String = ""
    
    let action: () -> Void
    
    var body: some View {
        Section(header: headerView) {
            TextFieldRowView(
                inputValue: $certainExpense.title,
                title: "Expense title",
                keyboardType: .default,
                placeholder: "New expense"
            )
            .listRowBackground(AppGradient.appBackgroundMini.value)
            
            TextFieldRowView(
                inputValue: $amount,
                title: "Amount",
                keyboardType: .decimalPad,
                placeholder: String(certainExpense.amount)
            )
            .listRowBackground(AppGradient.appBackgroundMini.value)
            .onChange(of: amount) { _, newValue in
                certainExpense.amount = Double(newValue) ?? 0
            }
            
            DateRowView(
                date: $certainExpense.date,
                title: "Choose date"
            )
            .listRowBackground(AppGradient.appBackgroundMini.value)
            
            NotificationRowView(
                notificationIsOn: $certainExpense.notification,
                title: "Notifications"
            )
            .listRowBackground(AppGradient.appBackgroundMini.value)
            
            NotificationRowView(
                notificationIsOn: $certainExpense.autoTransaction,
                title: "Autotransaction"
            )
            .listRowBackground(AppGradient.appBackgroundMini.value)
            
            if certainExpense.autoTransaction == true {
                TransactionRowView(action: {
                    //show modal
                }, title: "Transaction")
                .listRowBackground(AppGradient.appBackgroundMini.value)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Certain expense")
                .font(.bodyText1())
            
            Spacer()
            
            Button(action: action) {
                Image(systemName: "trash")
                    .foregroundStyle(.appBlack)
            }
        }
        .padding(.bottom, 6)
    }
}
    



#Preview {
    ExpenseSettingsView()
        .environment(CategoryService())
}
