//
//  IncomeScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 16.10.24.
//

import SwiftUI

struct IncomeScrollView: View {
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
                        if let income = category as? Income {
                            BaseCategoryCardView(
                                title: income.title,
                                subtitle: "",
                                icon: income.image,
                                currentAmount: income.amount,
                                plannedAmount: income.plannedAmount,
                                currency: income.currency
                            )
                            .frame(height: Constants.heightTwo)
                        }
                    }
                    
                    PlusButtonView {
                        router.navigateTo(.incomeSettings)
                    }
                }
            }
            .shadow()
        }
        .safeAreaPadding(.horizontal)
    }
}

#Preview {
    let income = DataManager.shared.getCategories(with: .income)
    return IncomeScrollView(categories: income).environment(Router())
}
