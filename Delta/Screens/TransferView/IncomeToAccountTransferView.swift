//
//  IncomeToAccountTransferView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 12/12/24.
//

import SwiftUI
import UISystem

struct IncomeToAccountTransferView: View {
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    @Environment(CategoryService.self) private var categoryService
    
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var tags: [Tag] = []
    
    var fromIncomeID: UUID
    var toAccount: Account
    
    var fromIncome: Income? {
        categoryService.incomes.first { $0.id == fromIncomeID }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TransactionFieldView(type: .source, income: fromIncome)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .padding(.top, 20)
                
                TransactionFieldView(type: .destination, account: toAccount)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                
                InputAmountView(amount: $amount)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                
                HStack(spacing: 16) {
                    DatePickerView(date: $date, title: "Date", background: AppGradient.appBackgroundMini, size: CGSize(width: Constants.widthHalfScreen, height: Constants.heightThree))
                    
                    TagPickerView(selectedTags: $tags)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
        .navigationTitle("Transfer")
        .background(.appBackground)
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let transaction: Transaction = Transaction(
                        id: UUID(),
                        amount: Double(amount) ?? 0,
                        date: date,
                        sourceID: fromIncomeID,
                        destinationID: toAccount.id,
                        tags: tags.map { $0.name },
                        currency: fromIncome?.currency ?? .usd,
                        person: nil,
                        autoTransaction: nil
                    )
                    
                    fromIncome?.transactions.append(transaction)
                    toAccount.transactions.append(transaction)
                    
                    dismiss()
                    
                    print(toAccount.title, toAccount.amount)
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                NavBarBackButtonView(dismiss)
            }
        }
    }
}

#Preview {
    IncomeToAccountTransferView(fromIncomeID: CategoryService().incomes.first!.id, toAccount: CategoryService().accounts.last!)
        .environment(CategoryService())
        .environment(Router.shared)
}
