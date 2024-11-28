//
//  InfoMainView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.09.24.
//

import SwiftUI

struct InfoMainView: View {
    var body: some View {
        VStack(spacing: 16) {
            MyBalanceView(
                totalBalance: 12325,
                myBalance: 100235,
                currency: .rub,
                image: "person"
            )
                
            HStack(spacing: 16) {
                VStack(spacing: 16) {
                    ExpenseIncomeView(
                        title: "Income",
                        currentAmount: 123235,
                        plannedAmount: 200235,
                        currency: .rub
                    )
                        
                    ExpenseIncomeView(
                        title: "Expense",
                        currentAmount: 123235,
                        plannedAmount: 200235,
                        currency: .rub
                    )
                }
                
                PlanVsActualView() 
            }
        }
        .shadow()
    }
}

#Preview {
    InfoMainView()
}
