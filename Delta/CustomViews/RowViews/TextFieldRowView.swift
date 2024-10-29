//
//  SettingsRowView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/26/24.
//

import SwiftUI

struct TextFieldRowView: View {
    @Binding var inputValue: String
    
    let title: String
    let keyboardType: UIKeyboardType
    let placeholder: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(placeholder, text: $inputValue)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.trailing)
                .keyboardType(keyboardType)
        }
        .padding(.vertical, 8)
        .frame(height: 37)
    }
        
}


struct PickerRowView: View {
    @Binding var currency: Currency
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("", selection: $currency) {
                ForEach(Currency.allCases) { currency in
                    Text(currency.rawValue).tag(currency)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .accentColor(.appBlack)
        }
        
        .padding(.vertical, 8)
        .frame(height: 37)
    }
}


struct DateRowView: View {
    @Binding var date: Date
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .accentColor(.appBlack)
            
        }
        .padding(.vertical, 8)
        .frame(height: 37)
    }
}

struct NotificationRowView: View {
    @Binding var notificationIsOn: Bool
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Toggle("", isOn: $notificationIsOn)
            
        }
        .padding(.vertical, 8)
        .frame(height: 37)
    }
}

struct TransactionRowView: View {
    //@Binding var notificationIsOn: Bool
    let action: () -> Void
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: action) {
                Image(systemName: "chevron.right")
                    .tint(.appBlack)
            }
            
        }
        .padding(.vertical, 8)
        .frame(height: 37)
    }
}


//#Preview {
//    SettingsRowView(
//        inputValue: .constant("Cash"),
//        currency: .constant(.usd),
//        source: DataStore.shared.accounts.first,
//        title: "Account Name",
//        type: .picker,
//        keyboardType: .numberPad,
//        placeholder: "Alpha"
//    )
//}

//#Preview {
//    DateRowView(
//        date: .constant(.now),
//        source: SubCategory(
//            id: UUID(),
//            title: "Avance",
//            currency: .usd,
//            categoryType: .income,
//            amount: 3000
//        ),
//        title: "Choose date"
//    )
//}

#Preview {
    NotificationRowView(
        notificationIsOn: .constant(true),
        title: "Notifications"
    )
}
