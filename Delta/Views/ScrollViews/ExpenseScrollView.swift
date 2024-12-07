//
//  ExpenseScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 23.11.24.
//

import SwiftUI

struct ExpenseScrollView: View {
    @Environment(Router.self) private var router
    
    let expenses: [Expense]
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
                    ForEach(expenses, id: \.id) { expense in
                        BaseCategoryCardView(
                            title: expense.title,
                            subtitle: "",
                            icon: expense.image,
                            currentAmount: expense.amount,
                            plannedAmount: expense.plannedAmount,
                            currency: expense.currency
                        )
                        .frame(height: Constants.heightTwo)
                        .onTapGesture {
                            router.navigateTo(.expenseSettings(expense: expense))
                        }
                        
                        .draggable(expense)
                        .dropDestination(for: AccountsAndGroups.self) { items, location in
                            router.navigateTo(.incomes)
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
    let expenses = CategoryService().expenses
    ExpenseScrollView(expenses: expenses, title: "Expense", settingsRoute: .incomeCreate, categoryRoute: .incomes)
        .environment(Router.shared)
}
