//
//  ExpenseIncomeView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 26.08.24.
//

import SwiftUI
import UISystem

struct ExpenseIncomeView: View {
    let title: String
    let currentAmount: Double
    let plannedAmount: Double
    let currency: Currency
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.metadata3())
                Spacer(minLength: 0)
                Text(currentAmount.formattedAmount(for: currency))
                    .font(.metadata1())
                
                Text(plannedAmount.formattedAmount(for: currency))
                    .font(.metadata3())
                    .foregroundStyle(.textGray)
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .componentBackground(
            color: AppGradient.appBackgroundMini.name,
            size: CGSize(width: Constants.widthTwo, height: Constants.heightOne)
        )
    }
}

#Preview {
    ExpenseIncomeView(
        title: "Расходы",
        currentAmount: 120000.87,
        plannedAmount: 78000.57,
        currency: .jpy
    )
}
