//
//  GoalCategoryCardView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 28.08.24.
//

import SwiftUI
import UISystem

struct GoalCategoryCardView: View {
    let title: String
    let currentAmount: Double
    let plannedAmount: Double
    let currency: Currency
    let image: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.bodyText1())
                Spacer()
                
                Text(currentAmount.formattedAmount(for: currency))
                    .font(.metadata1())

                Text(plannedAmount.formattedAmount(for: currency))
                    .font(.metadata3())
                    .foregroundStyle(.textGray)
                
                ProgressView(value: 0.7)
                    .tint(.appBlack)
                    .background(.appBackground)
            }
            .padding([.leading, .top, .trailing], 16)
            
            Image("visionpro")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Constants.widthTwo, height: Constants.heightTwo / 2)
                .clipped()
        }
        .componentBackground(
            color: AppGradient.appBackgroundMini.name,
            size: CGSize(width: Constants.widthTwo, height: Constants.heightTwo)
        )
    }
}

#Preview {
    GoalCategoryCardView(
        title: "Vision Pro",
        currentAmount: 2100,
        plannedAmount: 3000,
        currency: .usd, //TODO: - задать валюту цели
        image: "visionpro"
    )
}
