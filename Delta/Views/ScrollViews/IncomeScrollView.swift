//
//  IncomeScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 23.11.24.
//

import SwiftUI

struct IncomeScrollView: View {
    @Environment(Router.self) private var router
    
    let incomes: [Income]
    let title: String
    let settingsRoute: Route
    let categoryRoute: Route
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderMainView(text: title, action: {
                router.navigateTo(categoryRoute)
            })
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(incomes, id: \.id) { income in
                        BaseCategoryCardView(
                            title: income.title,
                            subtitle: "",
                            icon: income.image,
                            currentAmount: income.amount,
                            plannedAmount: income.plannedAmount,
                            currency: income.currency
                        )
                        .frame(height: Constants.heightTwo)
                        .onTapGesture {
                            router.navigateTo(.incomeSettings(income: income))
                        }
                        
                        .draggable(income)
                        .dropDestination(for: Expense.self) { items, location in
                            return true
                        }
                    }
                    
                    PlusButtonView {
                        router.navigateTo(settingsRoute)
                    }
                    .frame(width: Constants.widthOne)
                }
            }
            .shadow()
        }
        .safeAreaPadding(.horizontal)
    }
}

#Preview {
    let incomes = CategoryService().incomes
    IncomeScrollView(incomes: incomes, title: "Income", settingsRoute: .incomeCreate, categoryRoute: .incomes)
        .environment(Router.shared)
}
