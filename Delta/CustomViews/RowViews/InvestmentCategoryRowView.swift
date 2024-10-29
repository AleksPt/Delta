//
//  InvestmentCategoryRowView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/4/24.
//

import SwiftUI
import UISystem
import Charts

struct InvestmentCategoryRowView: View {
    let color: LinearGradient
    let icon: String
    let title: String
    let description: String
    let currency: Currency
    let amount: Double
    let percent: Double
    
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
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheading1())
                Text(description)
                    .font(.metadata3())
                    .foregroundStyle(AppGradient.textGray.value)
            }
            
            Spacer()
            
            Chart {
                ForEach(dailySales) { sale in
                    LineMark(
                        x: .value("", sale.time),
                        y: .value("", sale.sales)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.textGray)
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartXAxisLabel("")
            .chartYAxisLabel("")
            .chartPlotStyle { plotArea in
                plotArea
                    .background(Color.clear)
                    .border(Color.clear)
            }
            .frame(width: 80, height: 80)
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(amount.formattedAmount(for: currency))")
                    .font(.bodyText1())
                
                Text(percent, format: .percent)
                    .font(.metadata3())
                    .foregroundStyle(.textGray)
            }
        }
    }
}

#Preview {
    InvestmentCategoryRowView(
        color: AppGradient.appGray.value,
        icon: "house",
        title: "AAPL",
        description: "Apple Inc.",
        currency: .usd,
        amount: 58000,
        percent: 0.1268
    )
}
