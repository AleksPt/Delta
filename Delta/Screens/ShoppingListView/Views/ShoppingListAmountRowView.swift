//
//  ShoppingListAmountRowView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 27.09.24.
//

import SwiftUI

struct ShoppingListAmountRowView: View {
    @Bindable var category: Expense
    @State private var amountText: String = "0"
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey("Amount for \(category.title)"))
                .lineLimit(1)
                .layoutPriority(1)
            Spacer()
            TextField("0 p.", text: $amountText)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .onChange(of: amountText) { newValue, _ in
                    // Преобразование строки в Double
                    if let value = Double(newValue) {
                        category.amount = value
                    } else if newValue.isEmpty {
                        category.amount = 0.0
                    }
                }
        }
    }
}

//#Preview {
//    ShoppingListAmountRowView(category: )
//}
