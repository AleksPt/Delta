//
//  BaseCategoryCardView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 27.08.24.
//

import SwiftUI
import UISystem

struct BaseCategoryCardView: View {
    let title: String
    let subtitle: String
    let icon: String
    let currentAmount: Double
    let plannedAmount: Double
    let currency: Currency
    
    var body: some View {
        VStack(alignment: .leading) {

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.bodyText1())
                    Text(subtitle)
                        .font(.metadata3())
                        .foregroundStyle(.textGray)
                }
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(
                        .appBackground,
                        style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
                    )
                    .frame(height: 50)
                Circle()
                    .trim(from: 0, to: 0.65)
                    .rotation(.degrees(-90))
                    .stroke(
                        .appBlack,
                        style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
                    )
                    .frame(height: 50)
                Image(systemName: icon)
                    .font(.bodyText2())
            }
            Spacer()
            
            Text(currentAmount.formattedAmount(for: currency))
                .font(.metadata1())
//                .foregroundStyle(.red) //TODO: - isExceeded - red
            
            Text(plannedAmount.formattedAmount(for: currency))
                .font(.metadata3())
                .foregroundStyle(.textGray)
        }
        .padding()
        .componentBackground(
            color: AppGradient.appBackgroundMini.name,
            size: CGSize(width: Constants.widthTwo, height: Constants.heightTwo)
        )
    }
}

#Preview {
    BaseCategoryCardView(
        title: "Зарплата",
        subtitle: "Подзаголовок",
        icon: "briefcase",
        currentAmount: 58000,
        plannedAmount: 37000,
        currency: .egp
    )
}
