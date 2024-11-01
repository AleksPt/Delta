//
//  TransferView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI
import UISystem

struct TransferView: View {
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var tags: [Tag] = []
    @State private var isRepeatable: Bool = false
    
    @State private var title: String = ""
    @State private var repeatDate: Date = .now
    @State private var endDate: Date = .distantFuture
    @State private var period: Period = .month
    @State private var isNotify: Bool = false
    
    var account: Account?
    var income: Income?
    var expense: Expense?
    
    var body: some View {
        List {
            Section {
                textfieldView
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            
            Section {
                if let account {
                    TransactionFieldView(type: .source, account: account)
                }
                
                if let income {
                    TransactionFieldView(type: .source, income: income)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            
            Section {
                if let expense {
                    TransactionFieldView(type: .destination, expense: expense)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            
            Section {
                HStack(spacing: 16) {
                    DatePickerView(date: $date, title: "Date", background: AppGradient.appBackgroundMini)
                    
                    TagPickerView(selectedTags: $tags)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            
            Section {
                AutoTransactionView(
                    isRepeatable: $isRepeatable,
                    title: $title,
                    repeatDate: $repeatDate,
                    endDate: $endDate,
                    period: $period,
                    isNotify: $isNotify
                )
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            
        }
        .buttonStyle(.borderless)
        .scrollContentBackground(.hidden)
        .listSectionSpacing(.compact)
        .background(.appBackground)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var textfieldView: some View {
        VStack {
            TextField("Input amount", text: $amount)
                .font(.subheading1())
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
            Divider()
        }
    }
}

#Preview {
    TransferView(account: CategoryService().accounts.first, expense: CategoryService().expenses.first)
        .environment(CategoryService())
}
