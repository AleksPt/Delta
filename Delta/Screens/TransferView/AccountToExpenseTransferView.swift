//
//  AccountToExpenseTransferView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 12/12/24.
//

import SwiftUI
import UISystem

struct AccountToExpenseTransferView: View {
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    @Environment(CategoryService.self) private var categoryService
    
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var tags: [Tag] = []
    @State private var isRepeatable: Bool = false
    
    @State private var title: String = ""
    @State private var repeatDate: Date = .now
    @State private var endDate: Date = .now
    @State private var period: Period = .month
    @State private var isNotify: Bool = false
    
    var fromAccountID: UUID
    var toExpense: Expense
    
    var fromAccount: Account? {
        return categoryService.accounts.first { $0.id == fromAccountID }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TransactionFieldView(type: .source, account: fromAccount)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .padding(.top, 20)
                
                TransactionFieldView(type: .destination, expense: toExpense)
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
                
                AutoTransactionView(
                    isRepeatable: $isRepeatable,
                    title: $title,
                    repeatDate: $repeatDate,
                    endDate: $endDate,
                    period: $period,
                    isNotify: $isNotify
                )
                .padding(.horizontal, 16)
                
                Spacer()
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
                    let autoTransaction = AutoTransaction(
                        id: UUID(),
                        title: title,
                        repeatDate: repeatDate,
                        endDate: endDate,
                        period: period,
                        isNotify: isNotify
                    )
                    
                    let transaction: Transaction = Transaction(
                        id: UUID(),
                        amount: Double(amount) ?? 0,
                        date: date,
                        sourceID: fromAccountID,
                        destinationID: toExpense.id,
                        tags: tags.map { $0.name },
                        currency: fromAccount?.currency ?? .usd,
                        person: nil,
                        autoTransaction: isRepeatable ? autoTransaction : nil
                    )
                    
                    fromAccount?.transactions.append(transaction)
                    toExpense.transactions.append(transaction)
                    
                    dismiss()
                    
                    print(toExpense.title, toExpense.amount)
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                NavBarBackButtonView(dismiss)
            }
        }
    }
}

#Preview {
    AccountToExpenseTransferView(fromAccountID: CategoryService().accounts.first!.id, toExpense: CategoryService().expenses.last!)
        .environment(CategoryService())
        .environment(Router.shared)
}
