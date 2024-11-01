//
//  AutoTransactionView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 11/1/24.
//

import SwiftUI
import UISystem

struct AutoTransactionView: View {
    @Binding var isRepeatable: Bool
    @Binding var title: String
    @Binding var repeatDate: Date
    @Binding var endDate: Date
    @Binding var period: Period
    @Binding var isNotify: Bool
    
    var body: some View {
        VStack {
            NotificationRowView(notificationIsOn: $isRepeatable, title: "Repeat")
                .padding(.horizontal, 16)
            switch isRepeatable {
            case true:
                TextField("Title", text: $title)
                    .font(.subheading2())
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .padding(.horizontal, 16)
                Divider()
                    .padding(.horizontal, 16)
                
                HStack(spacing: 16) {
                    DatePickerView(date: $repeatDate, title: "Repeat date", background: AppGradient.appGray)
                    DatePickerView(date: $endDate, title: "End date", background: AppGradient.appGray)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                
                HStack(spacing: 16) {
                    choosePeriod()
                    isNotificationsOn()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            case false:
                EmptyView()
            }
        }
        .background(AppGradient.appBackgroundMini.value)
        .cornerRadius(16)
    }
    
    private func choosePeriod() -> some View {
        HStack {
            Picker("", selection: $period) {
                ForEach(Period.allCases, id: \.self) { period in
                    Text(period.title).tag(period)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .accentColor(.appBlack)
            .padding(.leading, 4)
        
            Spacer()
        }
        .frame(height: 42)
        .background(AppGradient.appGray.value)
        .cornerRadius(16)
    }
    
    private func isNotificationsOn() -> some View {
        HStack {
            Text("Notify")
                .padding(.leading, 16)
                .padding(.trailing, -20)
            Toggle("", isOn: $isNotify)
                .padding(.trailing, 6)
            
        }
        .frame(height: 42)
        .background(AppGradient.appGray.value)
        .cornerRadius(16)
    }
}


#Preview {
    AutoTransactionView(isRepeatable: .constant(true), title: .constant("Hello"), repeatDate: .constant(.now), endDate: .constant(.distantFuture), period: .constant(.month), isNotify: .constant(true))
}
