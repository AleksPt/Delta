//
//  PlanVsActualView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 27.08.24.
//

import Charts
import SwiftUI
import UISystem

struct Sale1: Identifiable {
    var id: String = UUID().uuidString
    var sales: Int
    var time: String
}

var dailySales1: [Sale] = [
    .init(sales: 10, time: "11:00"),
    .init(sales: 120, time: "12:00"),
    .init(sales: 80, time: "1:00"),
    .init(sales: 130, time: "2:00"),
    .init(sales: 240, time: "3:00"),
    .init(sales: 120, time: "4:00"),
    .init(sales: 50, time: "5:00"),
    .init(sales: 150, time: "6:00")
]

struct PlanVsActualView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle()
                    .foregroundStyle(.textGray)
                    .frame(width: 4, height: 4)
                Text("Plan")
                    .font(.metadata3())
                Circle()
                    .foregroundStyle(.appBlack)
                    .frame(width: 4, height: 4)
                Text("Actual")
                    .font(.metadata3())
                Spacer()
                Image(systemName: "info.circle")
                    .font(.metadata3())
            }
            
            Chart {
                ForEach(dailySales1) { sale in
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
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .componentBackground(
            color: AppGradient.appBackgroundMini.name,
            size: CGSize(width: Constants.widthThree, height: Constants.heightTwo)
        )
    }
}

#Preview {
    PlanVsActualView()
}
