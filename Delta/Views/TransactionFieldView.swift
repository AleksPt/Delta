//
//  TransactionFieldView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 10/31/24.
//

import SwiftUI
import UISystem

enum TransferType {
    case source
    case destination
}

struct TransactionFieldView: View {
    let type: TransferType
    
    var account: Account?
    var income: Income?
    var expense: Expense?
    
    var body: some View {
        VStack {
            HStack {
                switch type {
                case .source:
                    Label("Source", systemImage: "tray.and.arrow.up.fill")
                        .labelStyle(CustomLabel(spacing: 4))
                        .foregroundStyle(AppGradient.textGray.value)
                        .font(.bodyText2())
                case .destination:
                    Label("Destination", systemImage: "tray.and.arrow.down.fill")
                        .labelStyle(CustomLabel(spacing: 4))
                        .foregroundStyle(AppGradient.textGray.value)
                        .font(.bodyText2())
                }
                Spacer()
            }
            .padding(.horizontal)
            
            if let account {
                setContent(
                    color: account.color,
                    title: account.title,
                    symbol: account.currency.symbol,
                    amount: account.amount
                )
            }
            
            if let income {
                setContent(
                    color: AppGradient.appBlack.name,
                    title: income.title,
                    symbol: nil,
                    amount: nil
                )
            }
            
            if let expense {
                setContent(
                    color: AppGradient.appBlack.name,
                    title: expense.title,
                    symbol: nil,
                    amount: nil
                )
            }
        }
        .frame(height: 92)
        .background(AppGradient.appBackgroundMini.value)
        .cornerRadius(16)
    }
    
    private func setContent(
        color: String,
        title: String,
        symbol: String?,
        amount: Double?
    ) -> some View {
        HStack {
            Circle()
                .frame(width: 30)
                .foregroundStyle(AppGradient.getAppGradient(from: color)?.value ?? AppGradient.appBlue.value)
            Text(title)
                .font(.subheading2())
                .foregroundStyle(AppGradient.appBlack.value)
            
            Spacer()
            
            if let symbol, let amount {
                Text("\(symbol) \(String(amount))")
                    .font(.subheading1())
                    .foregroundStyle(AppGradient.appBlack.value)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    TransactionFieldView(type: .source, account: CategoryService().accounts.first)
}
