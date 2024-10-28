//
//  CategoriesScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.09.24.
//

import SwiftUI
import UISystem

struct CategoriesScrollView: View {
    @Environment(Router.self) private var router
    
    let categories: [Category]
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
                    ForEach(categories, id: \.id) { category in
                        BaseCategoryCardView(
                            title: category.title,
                            subtitle: "",
                            icon: getCategoryIcon(for: category),
                            currentAmount: getCurrentAmount(for: category),
                            plannedAmount: getPlannedAmount(for: category),
                            currency: category.currency
                        )
                        .frame(height: Constants.heightTwo)
                        .onTapGesture {
                            router.navigateTo(.expenseCreate)
                        }
                        
                        // TODO: - drag and drop
                        
                        .draggable(category)
                        
                        .dropDestination(for: Category.self) { droppedCategories, location in
                            router.navigateTo(.incomes)
                            return true
                        } isTargeted: { isTargeted in
                            // change appearance
                        }
                    }
                    
                    PlusButtonView {
                        router.navigateTo(settingsRoute)
                    }
                }
            }
            .shadow()
        }
        .safeAreaPadding(.horizontal)
    }
        
    private func getCategoryIcon(for category: Category) -> String {
        if let income = category as? Income {
            return income.image
        } else if let expense = category as? Expense {
            return expense.image
        }
        return ""
    }
    
    private func getCurrentAmount(for category: Category) -> Double {
        if let income = category as? Income {
            return income.amount
        } else if let expense = category as? Expense {
            return expense.amount
        }
        return 0
    }
    
    private func getPlannedAmount(for category: Category) -> Double {
        if let income = category as? Income {
            return income.plannedAmount
        } else if let expense = category as? Expense {
            return expense.plannedAmount
        }
        return 0
    }
}

#Preview {
    let income = DataManager.shared.getCategories(with: .income)
    CategoriesScrollView(categories: income, title: "Income", settingsRoute: .incomeCreate, categoryRoute: .incomes)
        .environment(Router.shared)
}
