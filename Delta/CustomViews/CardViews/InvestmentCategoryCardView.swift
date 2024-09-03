//
//  InvestmentCategoryCardView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 28.08.24.
//

import SwiftUI
import Charts
import UISystem

struct Sale: Identifiable {
    var id: String = UUID().uuidString
    var sales: Int
    var time: String
}

var dailySales: [Sale] = [
    .init(sales: 10, time: "11:00"),
    .init(sales: 120, time: "12:00"),
    .init(sales: 80, time: "1:00"),
    .init(sales: 130, time: "2:00"),
    .init(sales: 240, time: "3:00"),
    .init(sales: 120, time: "4:00"),
    .init(sales: 50, time: "5:00"),
    .init(sales: 150, time: "6:00")
]

struct InvestmentCategoryCardView: View {
    let title: String
    let subtitle: String
    let amount: Double
    let currency: Currency
    let percent: Double
    let image: String
    let size: CGSize
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
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
                        .frame(height: 32)
                        .foregroundStyle(.appBackground)
                    Image(systemName: image)
                        .font(.bodyText1())
                }
            }
            Spacer(minLength: 0)
            
            Chart {
                ForEach(dailySales) { sale in
                    LineMark(
                        x: .value("", sale.time),
                        y: .value("", sale.sales)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.appBlack)
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
            
            Spacer(minLength: 0)
            
            CurrencyTextView(currency: currency, amount: amount)
                .font(.bodyText1())

            Text(percent, format: .percent)
                .font(.metadata3())
                .foregroundStyle(.textGray)
        }
        .padding()
        .componentBackground(color: AppGradient.appBackgroundMini.name, size: size)
    }
}

#Preview {
    InvestmentCategoryCardView(
        title: "BTC",
        subtitle: "Bitcoin",
        amount: 60142,
        currency: .gbp, //TODO: - задать валюту
        percent: 0.0512,
        image: "bitcoinsign.circle.fill",
        size: CGSize(width: 144, height: 166)
    )
}
