//
//  HeaderMainView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.09.24.
//

import SwiftUI

struct HeaderMainView: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(LocalizedStringKey(text))
                .font(.heading1())
                .foregroundStyle(.appBlack)
            Spacer()
            ChevronButtonView(action: action)
        }
    }
}

#Preview {
    HeaderMainView(text: "Accounts", action: {})
}
