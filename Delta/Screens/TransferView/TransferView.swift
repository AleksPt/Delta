//
//  TransferView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI
import UISystem

struct TransferView: View {
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
    var toAccount: Account
    
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
                
                TransactionFieldView(type: .destination, account: toAccount)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                
                textfieldView
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
                        destinationID: toAccount.id,
                        tags: tags.map { $0.name },
                        currency: fromAccount?.currency ?? .usd,
                        person: nil,
                        autoTransaction: isRepeatable ? autoTransaction : nil
                    )
                    
                    fromAccount?.transactions.append(transaction)
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
    
    private var textfieldView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 60)
                .foregroundStyle(.appBackgroundMini)
            
            VStack {
                TextField("Input amount", text: $amount)
                    .font(.subheading1())
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
            }
        }
    }
}

#Preview {
    TransferView(fromAccountID: CategoryService().accounts.first!.id, toAccount: CategoryService().accounts.last!)
        .environment(CategoryService())
        .environment(Router.shared)
}
