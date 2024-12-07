//
//  GoalCategoryRowView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/4/24.
//

import SwiftUI
import UISystem

struct GoalCategoryRowView: View {
    let color: LinearGradient
    let image: String
    let title: String
    let currency: Currency
    let currentAmount: Double
    let plannedAmount: Double
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Text(title)
                    .font(.subheading1())
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(currentAmount.formattedAmount(for: currency))")
                        .font(.bodyText1())
                    
                    Text("\(plannedAmount.formattedAmount(for: currency))")
                        .font(.metadata2())
                        .foregroundStyle(AppGradient.textGray.value)
                }
                
                CircularProgressView(progress: currentAmount/plannedAmount)
            }
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 175)
                .clipped()
        }
    }
}

#Preview {
    GoalCategoryRowView(
        color: AppGradient.appGray.value,
        image: "iphone",
        title: "IPhone",
        currency: .usd,
        currentAmount: 58000,
        plannedAmount: 78000
    )
}
