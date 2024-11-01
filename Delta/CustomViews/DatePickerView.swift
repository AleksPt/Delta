//
//  DatePickerView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 10/31/24.
//

import SwiftUI
import UISystem

struct DatePickerView: View {
    @Binding var date: Date
    
    let title: String
    let background: AppGradient
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label(title, systemImage: "calendar")
                    .labelStyle(CustomLabel(spacing: 4))
                    .foregroundStyle(AppGradient.appBlack.value)
                    .padding(.horizontal, 16)
                Spacer()
            }
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .padding(.horizontal, 16)
        }
        .frame(height: 92)
        .background(background.value)
        .cornerRadius(16)
    }
}

struct CustomLabel: LabelStyle {
    var spacing: Double = 0.0
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}

#Preview {
    DatePickerView(date: .constant(.now), title: "Date", background: AppGradient.appGray)
}
