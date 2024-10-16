//
//  ExpenseScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 16.10.24.
//

import SwiftUI

struct ExpenseScrollView: View {
    @Environment(Router.self) private var router
    
    let categories: [Category]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderMainView(text: "Incomes", action: {
                router.navigateTo(.incomes)
            })
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(categories) { category in
                        if let expense = category as? Expense {
                            BaseCategoryCardView(
                                title: expense.title,
                                subtitle: "",
                                icon: expense.image,
                                currentAmount: expense.amount,
                                plannedAmount: expense.plannedAmount,
                                currency: expense.currency
                            )
                            .frame(height: Constants.heightTwo)
                        }
                    }
                    
                    PlusButtonView {
                        router.navigateTo(.expenseSettings)
                    }
                }
            }
            .shadow()
        }
        .safeAreaPadding(.horizontal)
    }
}

#Preview {
    let expense = DataManager.shared.getCategories(with: .expense)
    return ExpenseScrollView(categories: expense).environment(Router())
}
