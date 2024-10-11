//
//  RoundedButtonView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 30.08.24.
//

import SwiftUI

struct RoundedButtonView: View {
    let title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.bodyText2())
                .foregroundStyle(.appWhite)
        }
        .buttonStyle(.plain)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.appBlack)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    RoundedButtonView(title: "Delete account", action: {})
}
