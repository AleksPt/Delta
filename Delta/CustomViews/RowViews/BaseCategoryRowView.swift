//
//  BaseCategoryRowView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/2/24.
//

import SwiftUI
import UISystem

struct BaseCategoryRowView: View {
    let color: LinearGradient
    let icon: String
    let title: String
    let currency: Currency
    let currentAmount: Double
    let plannedAmount: Double
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .frame(width: 38)
                    .foregroundStyle(color)
                
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 18, height: 16)
            }
            
            Text(title)
                .font(.subheading2())
            
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
    }
}

#Preview {
    BaseCategoryRowView(
        color: AppGradient.appGray.value,
        icon: "house",
        title: "Аренда", 
        currency: .usd,
        currentAmount: 58000,
        plannedAmount: 78000
    )
}
