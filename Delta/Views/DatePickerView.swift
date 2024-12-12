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
    let size: CGSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Label(LocalizedStringKey(title), systemImage: "calendar")
                .labelStyle(CustomLabel(spacing: 4))
                .foregroundStyle(AppGradient.appBlack.value)
                .padding(.vertical, 6)
            
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .transformEffect(.init(scaleX: 0.8, y: 0.8))
            
        }
        .frame(width: size.width, height: size.height)
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
    DatePickerView(date: .constant(.now), title: "Date", background: AppGradient.appGray, size: CGSize(width: Constants.widthHalfScreen, height: Constants.heightThree))
}
