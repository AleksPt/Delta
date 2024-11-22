//
//  CategoriesScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.09.24.
//

import SwiftUI
import UISystem

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
                        
                        // TODO: - drag and drop
                        
                        .draggable(income)
                        
                        .dropDestination(for: Income.self) { droppedCategories, location in
                            //router.navigateTo(.incomes)
                            return true
                        } isTargeted: { isTargeted in
                            // change appearance
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
                        
                        // TODO: - drag and drop
                        
                        .draggable(expense)
                        
                        .dropDestination(for: Expense.self) { droppedCategories, location in
                            //router.navigateTo(.incomes)
                            return true
                        } isTargeted: { isTargeted in
                            // change appearance
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

//struct CategoriesScrollView<T>: View {
//    @Environment(Router.self) private var router
//    
//    let categories: [T]
//    let title: String
//    let settingsRoute: Route
//    let categoryRoute: Route
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HeaderMainView(text: title, action: {
//                router.navigateTo(categoryRoute)
//            })
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(categories, id: \.id) { category in
//                        BaseCategoryCardView(
//                            title: category.title,
//                            subtitle: "",
//                            icon: getCategoryIcon(for: category),
//                            currentAmount: getCurrentAmount(for: category),
//                            plannedAmount: getPlannedAmount(for: category),
//                            currency: category.currency
//                        )
//                        .frame(height: Constants.heightTwo)
//                        .onTapGesture {
//                            router.navigateTo(.expenseCreate)
//                        }
//                        
//                        // TODO: - drag and drop
//                        
//                        .draggable(category)
//                        
//                        .dropDestination(for: Category.self) { droppedCategories, location in
//                            router.navigateTo(.incomes)
//                            return true
//                        } isTargeted: { isTargeted in
//                            // change appearance
//                        }
//                    }
//                    
//                    PlusButtonView {
//                        router.navigateTo(settingsRoute)
//                    }
//                }
//            }
//            .shadow()
//        }
//        .safeAreaPadding(.horizontal)
//    }
//        
//    private func getCategoryIcon(for category: T) -> String {
//        if let income = category as? Income {
//            return income.image
//        } else if let expense = category as? Expense {
//            return expense.image
//        }
//        return ""
//    }
//    
//    private func getCurrentAmount(for category: T) -> Double {
//        if let income = category as? Income {
//            return income.amount
//        } else if let expense = category as? Expense {
//            return expense.amount
//        }
//        return 0
//    }
//    
//    private func getPlannedAmount(for category: T) -> Double {
//        if let income = category as? Income {
//            return income.plannedAmount
//        } else if let expense = category as? Expense {
//            return expense.plannedAmount
//        }
//        return 0
//    }
//}

#Preview {
    let incomes = CategoryService().incomes
    IncomeScrollView(incomes: incomes, title: "Income", settingsRoute: .incomeCreate, categoryRoute: .incomes)
        .environment(Router.shared)
}
