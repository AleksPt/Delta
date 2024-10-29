//
//  PlusButtonView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 30.08.24.
//

import SwiftUI

struct PlusButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: Constants.widthOne)
                    .foregroundStyle(.appBlack)
                
                Image(systemName: "plus")
                    .font(.subheading1())
                    .foregroundStyle(.appWhite)
            }
        }
    }
}

#Preview {
    PlusButtonView(action: {})
}
