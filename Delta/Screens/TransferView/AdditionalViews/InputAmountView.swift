//
//  InputAmountView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 12/12/24.
//

import SwiftUI
import UISystem

struct InputAmountView: View {
    @Binding var amount: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 60)
                .foregroundStyle(.appBackgroundMini)
            
            VStack {
                TextField("Input amount", text: $amount)
                    .font(.subheading1())
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
            }
        }
    }
}

#Preview {
    InputAmountView(amount: .constant("200"))
}
