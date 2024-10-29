//
//  IncomesView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/4/24.
//

import SwiftUI
import UISystem

struct IncomesView: View {
    @Environment(CategoryService.self) private var categoryService
    
    var body: some View {
        VStack {
            List(categoryService.incomes, id: \.self) { income in
                BaseCategoryRowView(
                    color: AppGradient.appGray.value,
                    icon: income.image,
                    title: income.title,
                    currency: income.currency,
                    currentAmount: income.amount,
                    plannedAmount: income.plannedAmount
                )
                .listRowSeparatorTint(Color.clear)
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Incomes")
        .navigationBarTitleDisplayMode(.large)
//        .toolbarBackground(.visible, for: .navigationBar)
//        .toolbarBackground(Color.appBackgroundMini, for: .navigationBar)
        .background(.appBackground)
    }
}

#Preview {
    IncomesView()
        .environment(CategoryService())
}
